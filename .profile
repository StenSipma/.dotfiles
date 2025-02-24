#!/bin/sh
## Filename: 	.profile
## Author: 	Sten Sipma

# Set XDG Directories from: $HOME/.config/user-dirs.dirs
# see: https://wiki.archlinux.org/index.php/XDG_Base_Directory
eval "$(sed 's/^[^#].*/export &/g;t;d' ~/.config/user-dirs.dirs)"

# Location for the go installation
export GOPATH="$XDG_DATA_HOME/go"

# Add local bin folders to PATH
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
PATH=$HOME/.local/bin:$PATH
PATH=$HOME/.cargo/bin:$PATH
PATH=$HOME/bin:$PATH
PATH=$HOME/go/bin:$PATH


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
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# AtomDB emissivity data
export ATOMDB=/home/sten/Documents/PhD/atomdb

# HEASoft init
export HEADAS="/opt/heasoft/x86_64-pc-linux-gnu-libc2.40"
alias heainit='. "/opt/heasoft/x86_64-pc-linux-gnu-libc2.40/headas-init.sh"'

# Fix Java window applications (like topcat)
export _JAVA_AWT_WM_NONREPARENTING=1

# Colours in less
export LESS="--raw-control-chars"

# Set the QT theme
export QT_QPA_PLATFORMTHEME=qt5ct

# Emoticons for pipx
USE_EMOJI=true

# Use 'bat' as the reader for the man pages
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -plman'"
# The above is a solution for bold text and colours not correctly showing up.
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Make the 'global' NPM installation user specific
# NOTE: incompatible with nvm
# export npm_config_prefix="$HOME/.local"

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
    if [[ -f "/usr/bin/prime-switch" ]]; then
        # sudo /usr/bin/prime-switch
        exec sh -c "startx ; sudo prime-switch"
    else
        exec startx
    fi
fi
