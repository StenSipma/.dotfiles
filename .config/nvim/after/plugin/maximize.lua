require('maximize').setup({
        default_keymaps = false,
})

-- Toggle and restore the maximize state
vim.keymap.set('n', '<leader>mt', require('maximize').toggle)
vim.keymap.set('n', '<leader>mr', require('maximize').restore)
