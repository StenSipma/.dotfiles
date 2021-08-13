" File:   statusline.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Configuring the statusline

set statusline=
" Show filename
set statusline+=%f\ %m
set statusline+=\ \  
set statusline+=%y
set statusline+=\ \  
" Some file status stuff, like [Help], [Quickfix], [+] for modified (%m) etc
set statusline+=%r%h%w%q

set statusline+=%=
" The file type
set statusline+=\ 
" Show percentage of current location
"set statusline+=%p%%
"set statusline+=\ 
" Show line/num-lines : column
set statusline+=%l/%L\ :\ %c
set statusline+=\ 
set statusline+=

" RESET
set statusline=
lua require('lualine').setup(require('sten.conf').lualine_conf)
