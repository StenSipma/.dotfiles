#!/bin/bash

echo "Adding XMonad recompile hook to pacman"
if [[ ! -f /etc/pacman.d/hooks/xmonad.hook ]]; then
        sudo mkdir -p /etc/pacman.d/hooks/
        sudo ln -sf ${XDG_CONFIG_HOME:-$HOME/.config}/pacman-hooks/xmonad.hook /etc/pacman.d/hooks/xmonad.hook
else
        echo "XMonad.hook already exists. Skipping..."
fi

echo "Installing XMonad"
sudo pacman -S --needed xmonad xmonad-contrib

echo "Installing used applications"
sudo pacman -S --needed \
        rofi \
        kitty \
        playerctl \
        flameshot \
        nitrogen \
        picom \
        stalonetray \
        pasystray \
        xmobar \
        peek \
        dunst \
        dmenu \
        xautolock \
        adobe-source-code-pro-fonts \
        noto-fonts \
        noto-fonts-emoji \
        ttf-nerd-fonts-symbols-2048-em \
        otf-hasklig-nerd \
        xdotool

paru -S --needed betterlockscreen
pacman -S --needed
mkdir -p $HOME/.wallpapers

