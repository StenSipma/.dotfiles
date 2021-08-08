" File:   scratch.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Interacting with a scratch buffer (creating a new one)

lua package.loaded['sten.scratch'] = nil
command Scratch lua require'sten.scratch'.open_scratch()
