" File:   tex.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Commands to run for a specific LaTeX (tex) buffer

" Sets Okular as the PDF viewer after compilation
" TODO: Move to a general file
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let b:delimitMate_quotes = "\" ' ` * $"

" Folding powered by Treesitter
set foldmethod=expr
set foldexpr=LuaFoldexpr()
set foldtext=LuaFoldtext()

" Set the runprg to initialize compilation. Vimtex should recompile whenever
" the buffer is saved.
let b:runprg = 'VimtexCompile'
