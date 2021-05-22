" File:   treesitter.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	The (Neo)Vim configuration file for the treesitter plugin

lua require'nvim-treesitter.configs'.setup ( require'configs'.treesitter_conf )
