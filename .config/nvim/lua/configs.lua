local all_attach = require'completion'.on_attach
local util = require('lspconfig/util')

local pyls_conf = {
        -- Not sure if this actually does anything...
        settings = {
                configurationSources = "flake8";
                plugins = {
                        pycodestyle = {
                                enabled = false;
                        };
                };
        };
        -- capabilities = capabilities;
        on_attach = all_attach;
}


local pyright_conf = {
        --root_dir = root_fallback;
        root_dir = util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt", "*.py");
        settings = {
                defaultVenv = {".env"};
                pyright = {
                        disableOrganizeImports = true;
                };
                python = {
                        analysis = {
                                autoSearchPaths = true;
                                useLibraryCodeForTypes = true
                        };
                };
        };
        on_attach = all_attach;
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
}

local texlab_conf = {
        on_attach = all_attach;
}

local rust_analyzer_conf = {
        on_attach = all_attach;
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
                -- disable = { "c", "rust" };
        };
};

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

return {
        pyls_conf = pyls_conf;
        treesitter_conf = treesitter_conf;
        pyright_conf = pyright_conf;
        telescope_conf = telescope_conf;
        lua_conf = lua_conf;
        texlab_conf = texlab_conf;
        rust_analyzer_conf = rust_analyzer_conf;
}
