#!/usr/bin/env sh

# Make sure to clone the repo before running
#mkdir -p $HOME/.dotfiles
#git clone --bare https://github.com/StenSipma/.dotfiles.git $HOME/.dotfiles

# Create the alias used for managing the repo
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Make backup of existing files
mkdir -p $HOME/.dotfiles-backup
dgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $HOME/.dotfiles-backup/{}

# Copy files to local system
dgit checkout

# Show only tracked files (cleans up a lot)
dgit config --local status.showUntrackedFiles no
dgit config user.email "sten.sipma@ziggo.nl"
dgit config user.name "Sten Sipma"
