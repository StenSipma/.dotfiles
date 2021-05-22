" File:   set-options.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for all the 'set' settings / options.
"       Each setting is documented, but the vim help contains a lot more info
"       and alternative options for each.  
"       For a list of all options: 
"               :help options

set exrc           " Allows for an .exrc (or .vimrc ?) file to exist inside a
                   " subdirectory, which allowing project specific 
                   " configuration

set relativenumber " Numbers on the number line are relative to the cursor
set nu             " Set the number on the cursor line to the line number
                   " (instead of 0)

set nowrap         " Do not wrap the line if it exceeds the window size
set scrolloff=3    " Scroll window down if cursor is 5 lines above/below the
                   " edges There exists a similar option for horizontal
                   " scrolling

set ruler          " Display current cursor position in the lower right corner
set showcmd        " Display incomplete commands in the lower right corner
set wildmenu       " Display command auto complete options as a status bar

set splitright     " <Ctrl-w>v splits to the right instead of left

set incsearch      " Display match for search pattern whilst typing
set ignorecase     " Case insensitive searching (i.e. using /, : etc.)
set smartcase      " Make search case sensitive if an upper case letter is used

set colorcolumn=80 " Display a vertical line at column 80

set tabstop=8 softtabstop=8 " Set the tab size
set shiftwidth=8            " Set the size used for indenting using >>
set expandtab               " Expand tabs into spaces
set autoindent              " Going to a newline retains the indentation of the
                            " current line

set hidden " Keep unsaved files active even in background (removes the 
           " force-save functionality when switching buffers)

set inccommand=split  " TODO: figure out what this does exactly
