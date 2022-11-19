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
        "autocmd BufEnter * lua require'completion'.on_attach()

        " Highlight the text yanked after yanking
        autocmd TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank()
augroup END

augroup RUN_BLACK
        autocmd!
        " Run black in python files
        autocmd BufWritePre *.py :call BlackSync()
augroup END


" Example Exceptions:
" augroup BLACK_DISABLE
"         autocmd!
"         " Disable Black formatting in NAME sub directories
"         autocmd! BufNewFile,BufRead */NAME/**/*.py autocmd! RUN_BLACK
" augroup END

" Remove whitespace at the end of the line on save, not giving errors if no
" patterns are found
" TODO: Make sure the user returns to original location when whitespace is removed
augroup REMOVE_WHITESPACE
        autocmd!
        autocmd BufWrite * :silent! %s/\s\+$//
augroup END
