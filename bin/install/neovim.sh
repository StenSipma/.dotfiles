#!/bin/bash
# install nvim

sudo pacman -S --needed xclip python tree-sitter neovim
paru -S --needed packer

# Make the python virtual environment
if [[ ! -d "${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs/neovim" ]]; then
        mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs
        python3 -m venv ${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs/neovim
        source ${XDG_CONFIG_HOME:-$HOME/.config}/pyvirtualenvs/neovim/bin/activate
        pip install pynvim
        # black can probably be removed as well.
        # pip install black
        deactivate
else
        echo "Virtual environment already created. Skipping..."
fi

# Install language servers
sudo pacman -S --needed rust-analyzer pyright gopls lua-language-server typescript-language-server texlab
