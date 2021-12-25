-- local all_attach = require'completion'.on_attach
local all_attach = nil
local util = require('lspconfig/util')

-- Enable snippet support
local all_capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').update_capabilities(all_capabilities)

local pylsp_conf = {
        on_attach = all_attach;
        capabilities = all_capabilities;
}

-- Resolves the root dir of a project (if it exists)
-- otherwise defaults to the current file.
local function python_root_dir(filename)
        return util.root_pattern("setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt", ".git")(filename) or util.path.dirname(filename);
end

local pyright_conf = {
        --root_dir = root_fallback;
        root_dir = python_root_dir;
        settings = {
                defaultVenv = {".env"};
                pyright = {
                        disableOrganizeImports = true;
                };
                python = {
                        analysis = {
                                autoSearchPaths = true;
                                useLibraryCodeForTypes = true;
                                extraPaths = {"."};
                        };
                };
        };
        -- on_attach = all_attach;
        capabilities = all_capabilities;
};

local lua_conf = {
        cmd = {'/usr/bin/lua-language-server'};
        settings = {
                Lua = {
                        runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                                -- Setup your lua path
                                path = vim.split(package.path, ';'),
                        },
                        diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = {'vim'},
                        },
                        workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = {
                                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                                },
                        },
                },
        },
        on_attach = all_attach;
        capabilities = all_capabilities;
}

local rust_analyzer_conf = {
        on_attach = all_attach;
        capabilities = all_capabilities;
}

local tsserver_conf = {
        on_attach = all_attach;
        capabilities = all_capabilities;
}

local gopls_conf = {
        settings = {
                gopls = {
                        codelenses = {
                                test = true;
                        }
                }
        };
        on_attach = all_attach;
        capabilities = all_capabilities;
}

local texlab_conf = {
        settings = {
                texlab = {
                        chktex = {
                                onEdit = true;
                        };
                };
        };
        on_attach = all_attach;
        capabilities = all_capabilities;
}

local treesitter_conf = {
        -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        -- TODO (2021-01-17): Convert into a list of languages
        ensure_installed = "maintained";
        indent = { enable = false; };
        incremental_selection = { enable = false; };
        highlight = {
                enable = true;
                -- list of language that will be disabled
                -- Markdown disabled by default (why?)
                -- LaTeX seems to have issues with large files, disabling for now
                disable = {"markdown", "latex"};
        };
        playground = {
                enable = true,
                updatetime = 25,
        };
        query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = {"BufWrite", "CursorHold"},
        };
};

local compe_conf = {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = {
                border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
                winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
                max_width = 120,
                min_width = 60,
                max_height = math.floor(vim.o.lines * 0.3),
                min_height = 1,
        };

        source = {
                path = true;
                buffer = true;
                emoji = true;
                --calc = true;
                -- Neovim specific
                nvim_lsp = { menu="殺" };
                nvim_lua = true;
                -- nvim_treesitter = true;
                -- Snippets
                ultisnips = { menu=' ', kind='﬌ ' };
                --vsnip = true;
                --luasnip = true;
        };
}

local telescope_conf = {
        defaults = {
                borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
                prompt_prefix = " 🔭";
                file_ignore_patterns = {
                        ".env";
                        "*.egg-info";
                        "vplugged";
                        "__pycache__/";
                };
        };
};

local statusline = require('sten.statusline')

local lualine_conf = {
        options = {
                theme = 'gruvbox-material';
        };

        -- Lualine has sections: [a>b>c     x<y<z]
        sections = {
                lualine_b = {'branch', 'diff'},
                -- lualine_x = {statusline.diagnostic_status, statusline.lsp_status, 'encoding', 'filetype'};
                -- lualine_x = {require'lsp-status'.status, 'encoding', 'filetype'};
                lualine_x = {{'diagnostics', sources={'nvim_diagnostic'}}, 'encoding', 'filetype'};
                lualine_z = {statusline.location};
        }
}

local lsp_status_conf = {
        indicator_errors = '',
        indicator_warnings = '',
        indicator_info = '',
        indicator_hint = '',
        indicator_ok = '',
}

local cmp = require('cmp')
local cmp_util = require('sten.cmp')
local kinds = require('sten.compl-kinds')

local cmp_conf = {
        snippet = {
                expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end
        };
        mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<Tab>'] = cmp.mapping({
                        i = cmp_util.TAB.i,
                        c = cmp_util.TAB.c,
                        s = cmp_util.TAB.s,
                }),
                ['<S-Tab>'] = cmp.mapping({
                        i = cmp_util.S_TAB.i,
                        c = cmp_util.S_TAB.c,
                        s = cmp_util.S_TAB.s,
                }),
                ['<C-n>'] = cmp.mapping({
                        i = cmp_util.C_n.i,
                        c = cmp_util.C_n.c,
                }),
                ['<C-p>'] = cmp.mapping({
                        i = cmp_util.C_p.i,
                        c = cmp_util.C_p.c,
                }),
                ['<CR>'] = cmp.mapping({
                        i = cmp_util.CR.i,
                        c = cmp_util.CR.c,
                })
        };
        formatting = { format = kinds.format };
        sources = cmp.config.sources({
                {name = 'nvim_lsp'},
                {name = 'buffer'},
                {name = 'path'},
                {name = 'emoji'},
                {name = 'ultisnips'},
                -- {name = 'latex_symbols'}, -- inserts actual unicode symbols
        });
}

local cmp_cmdline_search_conf = {
        completion = {autocomplete = false},
        sources = {
                -- Following keyword pattern matches an entire line, instead of a single word
                -- { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
                { name = 'buffer' }
        };
}

local cmp_cmdline_command_conf = {
        completion = {autocomplete = false},
        sources = cmp.config.sources({
                        {name = 'path'},
                        {name = 'cmdline'}
                })
}


return {
        treesitter_conf          = treesitter_conf;
        pyright_conf             = pyright_conf;
        pylsp_conf               = pylsp_conf;
        telescope_conf           = telescope_conf;
        lua_conf                 = lua_conf;
        rust_analyzer_conf       = rust_analyzer_conf;
        compe_conf               = compe_conf;
        lualine_conf             = lualine_conf;
        lsp_status_conf          = lsp_status_conf;
        tsserver_conf            = tsserver_conf;
        gopls_conf               = gopls_conf ;
        texlab_conf              = texlab_conf;
        cmp_conf                 = cmp_conf;
        cmp_cmdline_search_conf  = cmp_cmdline_search_conf;
        cmp_cmdline_command_conf = cmp_cmdline_command_conf;
}
