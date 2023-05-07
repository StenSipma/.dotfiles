require('nvim-treesitter.configs').setup({
        ensure_installed = {
                "c", "python", "go", "rust", "lua", "vim", "json", "html",
                "yaml", "javascript", "typescript", "markdown", "latex",
                "bash", "scss", "vue", "vimdoc",
        };

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed 
        -- locally
        auto_install = true,

        -- TODO: configure these options
        --indent = { enable = false; };
        --incremental_selection = { enable = false; };

        highlight = {
                enable = true;
                -- list of language that will be disabled
                -- Markdown disabled by default (why?)
                -- LaTeX seems to have issues with large files, disabling for now
                --disable = {"markdown", "latex"};

                -- Setting this to true will run `:h syntax` and tree-sitter at the 
                -- same time. Set this to `true` if you depend on 'syntax' being enabled
                -- (like for indentation). Using this option may slow down your editor,
                -- and you may see some duplicate highlights. Instead of true it can 
                -- also be a list of languages
                additional_vim_regex_highlighting = false,
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
})
