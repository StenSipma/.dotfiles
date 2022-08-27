#!/bin/bash

# Python
sudo pacman -S --needed python-pip python-pipx

# Rust
sudo pacman -S --needed rust

# Go
GOPATH=~/.local/share/go
sudo pacman -S --needed go

# Node (via NVM)
paru -S --needed nvm
if [ -n "$NVM_DIR" ]; then
        source /usr/share/nvm/init-nvm.sh
        nvm install 16
fi

# Docker
sudo pacman -S --needed docker
sudo systemctl enable --now docker.service
