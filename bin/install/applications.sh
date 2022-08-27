#!/bin/bash

sudo pacman -S --needed firefox obsidian mattermost-desktop thunderbird
# For obsidian
mkdir -p Documents/Obstenian

# Import key required by spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
paru -S --needed spotify

# Nextcloud client
sudo pacman -S --needed nextcloud-client qtkeychain-qt5 libsecret kwallet
