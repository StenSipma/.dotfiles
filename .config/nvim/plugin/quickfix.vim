" File:   quickfix.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Configuration file for the Quickfix List functionality.

" Jumping between entries in the quickfix list 
noremap <leader>qj <cmd>cnext<cr>
noremap <leader>qk <cmd>cprevious<cr>

" Opening and closing the quickfix list window
noremap <leader>qo <cmd>copen<cr>
noremap <leader>qq <cmd>cclose<cr>
