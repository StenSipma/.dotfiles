#!/bin/bash
# install nvim
paru -S --needed neovim-nightly-bin
sudo pacman -S --needed xclip python

# Install plug.vim
if [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]]; then
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
        echo "Plug.vim already exists. Skipping..."
fi

# Make the python virtual environment
if [[ ! -d "$XDG_CONFIG_HOME/pyvirtualenvs/neovim" ]]; then
        mkdir -p $XDG_CONFIG_HOME/pyvirtualenvs
        python3 -m venv $XDG_CONFIG_HOME/pyvirtualenvs/neovim
        source $XDG_CONFIG_HOME/pyvirtualenvs/neovim/bin/activate
        pip install pynvim
        pip install black
        deactivate
else
        echo "Virtual environment already created. Skipping..."
fi

# Install language servers
sudo pacman -S --needed rust-analyzer pyright gopls lua-language-server typescript-language-server texlab
