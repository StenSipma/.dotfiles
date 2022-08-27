#!/bin/bash

# Python
sudo pacman -S --needed python-pip python-pipx
# Needed to resolve issue with keys
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
paru -S --needed python39

# Rust
sudo pacman -S --needed rust

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
sudo pacman -S --needed docker
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

# Tmux
sudo pacman -S --needed tmux
