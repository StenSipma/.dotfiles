" File:   rust.vim
" Author: Sten Sipma <sten.sipma@ziggo.nl>
" Description:
"      Rust specific commands

" Don't autoformat, since it is too slow. Find something else
let g:rustfmt_autosave = 0

" Folding powered by Treesitter
set foldmethod=expr
set foldexpr=LuaFoldexpr()
set foldtext=LuaFoldtext()
