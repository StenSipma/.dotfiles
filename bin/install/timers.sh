#!/bin/bash

sudo ln -s ${XDG_CONFIG_HOME:-$HOME/.config}/timers/pacman-index-update/pacman-index-update.service /usr/lib/systemd/system/pacman-index-update.service
sudo ln -s ${XDG_CONFIG_HOME:-$HOME/.config}/timers/pacman-index-update/pacman-index-update.timer   /usr/lib/systemd/system/pacman-index-update.timer
sudo systemctl daemon-reload
sudo systemctl enable --now pacman-index-update.timer
