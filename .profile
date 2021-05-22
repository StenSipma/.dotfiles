#!/bin/sh
## Filename: 	.profile
## Author: 	Sten Sipma

# Set XDG Directories from: $HOME/.config/user-dirs.dirs
# see: https://wiki.archlinux.org/index.php/XDG_Base_Directory
eval "$(sed 's/^[^#].*/export &/g;t;d' ~/.config/user-dirs.dirs)"

# Add local bin folders to PATH
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
PATH=~/.local/bin:$PATH
PATH=~/bin:$PATH


##########################
#- Default Applications -#
##########################
export BROWSER="firefox"
export TERMINAL="st"
export MAIL_READER="thunderbird"
export EDITOR="nvim"
export PAGER="less"
export IMAGE_VIEWER="sxiv"
export PRINTER="DCPJ515W"


#############################
#- Clean Up Home Directory -#
#############################
#export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc

export SQLITE_HISTORY=$XDG_CACHE_HOME/sqlite_history
export MYSQL_HISTFILE="$XDG_CACHE_HOME"/mysql_history 
export HISTFILE="$XDG_CACHE_HOME"/bash/history 
export _Z_DATA="$XDG_CACHE_HOME/z" 
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc 
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl" 


# PostgreSQL
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"


# disable less' history file
export LESSHISTFILE=-

alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

#################################
#- Other Configuration Options -#
#################################

# Fix Java window applications (like topcat)
export _JAVA_AWT_WM_NONREPARENTING=1

# Colours in less
export LESS="--raw-control-chars"

# Set the QT theme
export QT_QPA_PLATFORMTHEME=qt5ct

# Emoticons for pipx
USE_EMOJI=true

# Use 'bat' as the reader for the man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Source bashrc as well if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi


## Start the X session:
# (! $DISPLAY)      : If there is no current display (?)
# ($XDG_VTNR -eq 1) : If the VT number equals 1 (e.g. Ctrl+Alt+F1)
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	# For Optimus-Manager
 	#sudo /usr/bin/prime-switch
	exec startx
fi

# Created by `userpath` on 2021-02-03 12:28:46
export PATH="$PATH:/home/sten/.local/bin"
