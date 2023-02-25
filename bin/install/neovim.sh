#!/bin/bash
# install nvim
paru -S --needed neovim-nightly-bin packer
sudo pacman -S --needed xclip python tree-sitter

# Make the python virtual environment
if [[ ! -d "${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs/neovim" ]]; then
        mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs
        python3.10 -m venv ${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs/neovim
        source ${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs/neovim/bin/activate
        pip install pynvim
        pip install black
        deactivate
else
        echo "Virtual environment already created. Skipping..."
fi

# Install language servers
sudo pacman -S --needed rust-analyzer pyright gopls lua-language-server typescript-language-server texlab
