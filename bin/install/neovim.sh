#!/bin/bash
# install nvim
paru -S --needed neovim-nightly-bin
sudo pacman -S --needed xclip python

# Install plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Make the python virtual environment
mkdir -p $XDG_CONFIG_HOME/pyvirtualenvs
python3 -m venv $XDG_CONFIG_HOME/pyvirtualenvs/neovim
source $XDG_CONFIG_HOME/pyvirtualenvs/neovim/bin/activate
pip install pynvim
pip install black
deactivate
