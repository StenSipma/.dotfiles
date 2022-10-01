" File:   highlight.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	File which defines custom highlights


" CmpItemMenu is currently used to display the source of the completion. This
" makes it pop out less.
highlight link CmpItemMenu Comment

" Highlight trailing whitespaces with red
highlight link ExtraWhitespace TSDanger
match ExtraWhitespace /\s\+$/
