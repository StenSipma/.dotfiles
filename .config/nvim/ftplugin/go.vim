" File:   go.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Go specific settings, only executed when a go file/buffer is opened

" Folding powered by Treesitter
set foldmethod=expr
set foldexpr=LuaFoldexpr()
set foldtext=LuaFoldtext()
