#!/bin/bash

TMP_DIR='/tmp/myprompt'
mkdir -p $TMP_DIR

git clone https://github.com/StenSipma/myprompt.git $TMP_DIR
pushd $TMP_DIR
cargo install --path .
popd
rm -rf $TMP_DIR

if [[ ! -f /etc/pacman.d/hooks/myprompt.hook ]]; then
        sudo mkdir -p /etc/pacman.d/hooks/
        sudo echo "Making pacman update hook for myprompt..."
        sudo ln -sf $XDG_CONFIG_HOME/pacman-hooks/myprompt.hook /etc/pacman.d/hooks/myprompt.hook
else
        echo "myprompt.hook already exists. Skipping..."
fi
