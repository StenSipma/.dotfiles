" File:   python.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Python specific mappings. File is run (each time ?) when a python
"	buffer is opened.

" Remap the jump to function mappings from Pythonsense
nmap <buffer> { [m
nmap <buffer> } ]m

" Pressing any of the characters in this list three times will cause a three
" more to appear behind the cursor (Plugin: delimitMate)
let b:delimitMate_nesting_quotes = ['"','`']

" Folding powered by Treesitter
set foldmethod=expr
set foldexpr=LuaFoldexpr()
set foldtext=LuaFoldtext()
