#!/bin/bash

echo "Installing Xmonad"
sudo pacman -S --needed xmonad xmonad-contrib
xmonad --recompile

echo "Installing used applications"
sudo pacman -S --needed rofi kitty playerctl flameshot nitrogen picom stalonetray pasystray nextcloud-client xmobar dunst dmenu xautolock adobe-source-code-pro-fonts noto-fonts noto-fonts-emoji
paru -S --needed betterlockscreen otf-hasklig nerd-fonts-fira-code
