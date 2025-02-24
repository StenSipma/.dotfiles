local lsp = require('lsp-zero')
local util = require('lspconfig/util')
local cmp = require('cmp')
local luasnip = require('luasnip')
local null_ls = require("null-ls")
local mason = require('mason')
local mason_registry = require("mason-registry")

-- Setup mason for if we need to install
mason.setup()

-- Custom 'ensure_installed' for Mason
local mason_packages = { 'black', 'flake8', 'isort' }
for _, package in ipairs(mason_packages) do
    if not mason_registry.is_installed(package) then
        print(string.format("Package %s is not installed, installing via Mason...", package))
        vim.cmd(string.format(":MasonInstall %s", package))
    end
end


lsp.preset("recommended")

-- TODO: Probably the local/system installs are no longer required.
lsp.ensure_installed({
    -- 'sumneko_lua',
    'lua_ls',
    'rust_analyzer',
    'pyright',
    'texlab',
    'gopls',
    -- 'tsserver',
})

-- Add compatibility with your NeoVim lua configuration
lsp.nvim_workspace()


-- cmp Keymaps
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

    -- Toggle visibility of cmp menu
    ['<C-Space>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.close()
            fallback()
        else
            cmp.complete()
        end
    end),

    -- go to next placeholder in the snippet (if possible)
    ['<C-j>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        else
            fallback()
        end
    end, { 'i', 's' }),

    -- go to previous placeholder in the snippet (if possible)
    ['<C-k>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { 'i', 's' }),
})

vim.keymap.set("i", "<C-l>", function()
    if luasnip.expandable() then
        luasnip.expand()
    end
end)

-- Remove default mappings
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
cmp_mappings['<CR>'] = nil
cmp_mappings['<Up>'] = nil
cmp_mappings['<Down>'] = nil
cmp_mappings['<C-d>'] = nil
cmp_mappings['<C-e>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer',  keyword_length = 2 },
        { name = 'luasnip' },
    },
    formatting = { format = require('sten.cmp-kinds').format },

})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

vim.diagnostic.config({
    virtual_text = true,
})

----------------------------------
-- Specific LSP configurations
----------------------------------

-- Resolves the root dir of a project (if it exists)
-- otherwise defaults to the current file.
local function python_root_dir(filename)
    return util.root_pattern("setup.py", "setup.cfg", "pyproject.toml", "requirements.txt", ".git")(filename) or
        -- util.path.dirname(filename);
        vim.fs.dirname(filename);
end

-------------
-- Python
lsp.configure('pyright', {
    root_dir = python_root_dir,
    settings = {
        defaultVenv = { ".env" },
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = false,
                extraPaths = { "." },
            },
        },
    },
})

-------------
-- Lua
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

-------------
-- Go
lsp.configure('gopls', {
    settings = {
        gopls = {
            codelenses = {
                test = true,
            }
        }
    },
})

-------------
-- LaTeX
lsp.configure('texlab', {
    settings = {
        texlab = {
            chktex = {
                onEdit = true,
            },
        },
    },
})

-------------
-- Formatting
-- requires: black, flake8, isort
-- set up null_ls
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black.with({
            extra_args = { "--fast" },
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,
    },
});
-- And then activate it with lsp
lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['null-ls'] = { 'python' },
    }
})


-------------
-- Rust
-- Make an empty object first, and then call rust-tools after the setup
local rust_lsp = lsp.build_options('rust_analyzer', {})


-- Finally call setup
lsp.setup()

require('rust-tools').setup({
    server = rust_lsp,
    tools = {
        inlay_hints = {
            parameter_hints_prefix = " <- ",
            other_hints_prefix = " :: ",
            max_len_align = true,
        }
    }
})

require('sten.luasnip').init_snippets()
require('luasnip.loaders.from_vscode').lazy_load() -- Load snippets from friendly-snippets
