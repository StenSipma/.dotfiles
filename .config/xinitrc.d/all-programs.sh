#!/bin/bash

# Set the lock screen
xautolock -time 10 -corners ---- -locker "betterlockscreen -l dimblur" &

# Notification server
/usr/bin/dunst &
