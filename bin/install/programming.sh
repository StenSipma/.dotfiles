#!/bin/bash

# Python
sudo pacman -S --needed python-pip python-pipx
# Needed to resolve issue with keys
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
paru -S --needed python39 python36

# Rust

# Old way of installing
#sudo pacman -S --needed rust
# Following is better when programming with rust
sudo pacman -S --needed rustup
rustup default stable


# Go
GOPATH=~/.local/share/go
sudo pacman -S --needed go

# Node (via NVM)
paru -S --needed nvm
if [[ ! -n "$NVM_DIR" ]]; then
        source /usr/share/nvm/init-nvm.sh
        nvm install 16
else
        echo "nvm already installed. Skipping..."
fi

# Docker
sudo pacman -S --needed docker docker-compose
sudo systemctl enable --now docker.service

# Jupyter hub
sudo pacman -S --needed jupyter-notebook
paru -S --needed jupyter_contrib_nbextensions

if [[ ! -d $(jupyter --data-dir)/nbextensions/vim_binding ]]; then
        mkdir -p $(jupyter --data-dir)/nbextensions
        cd $(jupyter --data-dir)/nbextensions
        git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
        jupyter nbextension enable vim_binding/vim_binding
else
        echo "Vim bindings already installed"
fi

jupyter nbextension install --user toc2
jupyter nbextension enable --user toc2/toc2

# Tmux
sudo pacman -S --needed tmux

# Git tools
# A better diff viewer
sudo pacman -S --needed git-delta

# Latex
#  TODO: Make the selection automatic
sudo pacman -S --needed textlive-most
