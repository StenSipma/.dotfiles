local builtin = require('telescope.builtin')

-- p: 'project'
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<leader>pt", builtin.git_files)
vim.keymap.set("n", "<leader>pg", builtin.live_grep)
vim.keymap.set("n", "<leader>pb", builtin.buffers)

-- l: 'list'
vim.keymap.set("n", "<leader>lh", builtin.help_tags)
vim.keymap.set("n", "<leader>lo", builtin.vim_options)
-- Diagnostics can be jumped to using the options in `lsp.lua`
--vim.keymap.set("n", "<leader>vld", builtin.diagnostics)

-- Custom options
require('telescope').setup({
    defaults = {
        sorting_strategy = "descending",
        -- sorting_strategy = "ascending", -- TEMP fix for invisible filenames
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        prompt_prefix = " 🔭 ",
        file_ignore_patterns = {
            "%.venv", "%.env", "*%.egg-info", "__pycache__/",                                -- Python stuff
            "%.aux", "%.bbl$", "%.blg", "%.fdb_latexmk", "%.fls", "%.synctex%.gz", "%.toc$", -- LaTeX stuff
        },
    },
})
