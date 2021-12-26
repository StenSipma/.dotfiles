" File:   lua.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Some config options and functions which are convenient for lua inside
"	NeoVim

" Syntax highlighting for lua code inside a .vim file
let g:vimsyn_embed = 'l'

" Make some functions global:
lua << EOF
_G.dump = require'sten.util'.dump
EOF
