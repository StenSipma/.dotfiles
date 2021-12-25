" File:   completion.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	File which configures the completion framework (compe or completion)

" Options:
" Set completeopt to have a better completion experience
" menu:     use a popup menu if there is a completion
" menuone:  also show menu when only one match is found
" noselect: do not select an item in the menu by default
set completeopt=menu,menuone,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c

" Enable cmp
lua require('cmp').setup( require('sten.conf').cmp_conf )
lua require('cmp').setup.cmdline('/', require('sten.conf').cmp_cmdline_search_conf)
lua require('cmp').setup.cmdline(':', require('sten.conf').cmp_cmdline_command_conf)
