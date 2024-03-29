#!/bin/bash

sudo pacman -S --needed firefox obsidian mattermost-desktop thunderbird discord chromium pinta
# For obsidian
mkdir -p Documents/Obstenian

# Import key required by spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
paru -S --needed spotify

# Nextcloud client, with secret management
sudo pacman -S --needed nextcloud-client qtkeychain-qt5 libsecret kwallet gnome-keyring

# Zotero, reference manager
paru -S --needed zotero

# Okular, pdf viewer
sudo pacman -S --needed okular

# Drawing Tablet
sudo pacman -S --needed xournalpp xf86-input-wacom

# Image viewer
paru -S --needed nomacs
