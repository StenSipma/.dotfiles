#!/bin/bash

# Install stuff
sudo pacman -S --needed zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions
sudo pacman -S --needed zoxide fzf

# Select zsh as shell
if [[ $SHELL != '/bin/zsh' ]]; then
        chsh -s /bin/zsh
else
        echo "Shell is already Zsh"
fi
