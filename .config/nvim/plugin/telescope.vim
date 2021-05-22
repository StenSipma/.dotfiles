" File:   lsp.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for the Telescope plugin

" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>lua require'telescope.builtin'.find_files{find_command={'fd', '--no-ignore-vcs', '--type', 'f'}}<cr>
nnoremap <leader>fv <cmd>lua require'telescope.builtin'.find_files()<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fo <cmd>lua require'telescope.builtin'.vim_options()<cr>
nnoremap <leader>ft <cmd>lua require'telescope.builtin'.treesitter()<cr>
nnoremap <leader>fa <cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>
nnoremap <leader>fi <cmd>lua require'sten.telescope'.fits_inspect()<cr>

lua require('telescope').setup(require'configs'.telescope_conf)
