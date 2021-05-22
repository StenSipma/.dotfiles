" File:   autocommands.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for all autocommand settings. Make sure to
"       add a autocmd! at the beginning of each group to clear all the
"       previous autocmd settings from within the group.

augroup MY_AUTOCOMMANDS
	autocmd!
        " Turns hlsearch on briefly while searching, turns it off after
	autocmd CmdlineEnter /,\? :set hlsearch
	autocmd CmdlineLeave /,\? :set nohlsearch

        " Enable completion for all filetypes
        autocmd BufEnter * lua require'completion'.on_attach()

        " Highlight the text yanked after yanking
        autocmd TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank()
augroup END

augroup RUN_BLACK
        autocmd!
        " Run black in python files
        autocmd BufWrite *.py :Black
augroup END


" Exceptions:
augroup LEARNIT
        autocmd!
        
        " Disable Black formatting in learnit sub directories
        autocmd! BufNewFile,BufRead */Learnit/**/*.py autocmd! RUN_BLACK
augroup END
