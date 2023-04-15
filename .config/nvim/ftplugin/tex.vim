" File:   tex.vim
" Author:  Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"      Commands to run for a specific LaTeX buffer

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let b:delimitMate_quotes = "\" ' ` * $"

let b:runprg = 'VimtexCompile'
