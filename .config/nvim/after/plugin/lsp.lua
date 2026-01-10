local cmp = require('cmp')
local luasnip = require('luasnip')
local conform = require('conform')

-------------------------------------------------
-- Mason: ensure external tools are present
-------------------------------------------------
-- local mason = require("mason")
-- mason.setup()

-- Install black, flake8, isort if missing (Python formatters)
-- local fmt_pkgs = { 'black', 'flake8', 'isort' }
-- for _, pkg in ipairs(fmt_pkgs) do
--   if not mason_registry.is_installed(pkg) then
--     vim.cmd(('MasonInstall %s'):format(pkg))
--   end
-- end

-- LSP servers we want Mason to manage
-- mason_lspconfig.setup {
--   ensure_installed = {
--     'lua_ls',
--     'rust_analyzer',
--     'pyright',
--     'texlab',
--     -- 'gopls',   -- uncomment when you need Go support
--   },
-- }

-------------------------------------------------
-- Global diagnostic / UI preferences
-------------------------------------------------
vim.diagnostic.config {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
}

local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-------------------------------------------------
-- Completion (nvim-cmp) – keymaps & sources
-------------------------------------------------
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-Space>'] = cmp.mapping(function(fallback)
        if cmp.visible() then cmp.close() else cmp.complete() end
    end),

    ['<C-j>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end
    end, { 'i', 's' }),

    ['<C-k>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
    end, { 'i', 's' }),

    ['<C-l>'] = cmp.mapping(function()
        if luasnip.expandable() then luasnip.expand() end
    end, { 'i' }),
})

-- Remove unwanted defaults
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
cmp_mappings['<CR>'] = nil
cmp_mappings['<Up>'] = nil
cmp_mappings['<Down>'] = nil
cmp_mappings['<C-d>'] = nil
cmp_mappings['<C-e>'] = nil

cmp.setup {
    mapping = cmp_mappings,
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer',  keyword_length = 2 },
    },
    formatting = { format = require('sten.cmp-kinds').format },
}

-- Enable LSP source for nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-------------------------------------------------
-- Helper: on_attach (keybindings per buffer)
-------------------------------------------------
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end


vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = capabilities,
})

-------------------------------------------------
-- Server‑specific configurations
-------------------------------------------------

-- Python (pyright) – custom root detection
-- OLD: util.root_pattern doesn't work anymore,
-- local function python_root_dir(fname)
--   return util.root_pattern('setup.py', 'setup.cfg', 'pyproject.toml', 'requirements.txt', '.git')(fname)
--       or vim.fs.dirname(fname)
-- end

vim.lsp.config('pyright', {
    -- Test that this still works for a single Python file
    root_markers = { { 'setup.py', 'setup.cfg', 'pyproject.toml', 'requirements.txt' }, '.git' },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = false,
                extraPaths = { '.' },
            },
        },
        pyright = { disableOrganizeImports = true },
        defaultVenv = { '.venv' },
    },
})

-- Lua (lua_ls) – make Neovim runtime visible
vim.lsp.config('lua_ls', {
    -- root_dir = function(bufnr, on_dir)
    --   if not vim.fn.bufname(bufnr):match('%.lua$') then
    --     on_dir(vim.fn.getcwd())
    --   end
    -- end,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

-- -- Rust (rust_analyzer) – using rust-tools for extra UI
-- local rust_opts = {
--   -- you can extend this table with rust-analyzer specific settings
-- }
-- rust_tools.setup {
--   server = vim.tbl_extend('force', rust_opts, {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }),
--   tools = {
--     inlay_hints = {
--       parameter_hints_prefix = ' <- ',
--       other_hints_prefix = ' :: ',
--       max_len_align = true,
--     },
--   },
-- }

-- LaTeX (texlab)
vim.lsp.config('texlab', {
    filetypes = { "tex" },
    settings = {
        texlab = {
            chktex = { onEdit = true },
        },
    },
})

-- Nix (nixd)
vim.lsp.config('nixd', {
    settings = {
        nixd = {
            nixpkgs = {
                expr = 'import <nixpkgs> { }',
            },
            formatting = {
                command = { 'nixfmt' },
            },
            -- If you want autocomplete for specific flakes (i.e. from custom options!)
            -- options = {
            --     nixos = {
            --         expr = '(builtins.getFlake "SOME NIX FLAKE PATH").nixosConfigurations.SYSTEM_NAME.options',
            --     }
            -- }
        },
    },
})


-- Uncomment and adapt when you need Go support
-- vim.lsp.config('gopls', {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })
-- vim.lsp.enable('gopls')

vim.lsp.enable({ 'texlab', 'lua_ls', 'pyright', 'nixd' })
-------------------------------------------------
-- Formatting – conform.nvim (replaces null‑ls usage)
-------------------------------------------------
conform.setup {
    formatters_by_ft = {
        python = { 'isort', 'black' },
        nix = { 'nixfmt' },
        -- add other filetypes here if desired
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
    },
}

-- If you still want to trigger formatting manually:
vim.api.nvim_create_user_command('Format', function(args)
    conform.format { async = false, lsp_fallback = true }
end, {})

-------------------------------------------------
-- Snippet loading (friendly‑snippets)
-------------------------------------------------
require('luasnip.loaders.from_vscode').lazy_load()
require('sten.luasnip').init_snippets()

-- mason_registry.refresh(function()
--   for _, pkg in ipairs(mason_lspconfig.get_installed_servers()) do
--     -- No‑op; just forces Mason to notice newly installed servers
--   end
-- end)

-------------------------------------------------
-- Commands for Log and Info
-------------------------------------------------
vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
    desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
end, {
    desc = "Get all the information about all LSP attached",
})
