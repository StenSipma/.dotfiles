#!/bin/bash

# Refresh the package database at login, so we can use `pacman -Qu` to list
# all the available updates.
pacman -Syq
