" File:   delimitMate.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       Configuration options for delimitMate

" Needed for delimitMate_expand_cr to work (should be the default)
set backspace=2 

" NOTE: When <CR> or <SPACE> are overridden, these expansions will not work
"       (for instance when using a completion framework, which has custom
"       behavior on the <CR> key). In this case, use the delimitMateCR
"       function instead of the normal <CR>, to still have the option work.
"       (see the plugin/completion.vim file)
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
