#!/usr/bin/env sh

# Make sure you are in `$HOME`
# Clone repo to the machine
git clone --bare https://github.com/StenSipma/.dotfiles.git $HOME/.dotfiles

# Create the alias used for managing the repo
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Make backup of existing files
mkdir .dotfiles-backup
dgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}

# Copy files to local system
dgit checkout

# Show only tracked files (cleans up a lot)
dgit config --local status.showUntrackedFiles no
