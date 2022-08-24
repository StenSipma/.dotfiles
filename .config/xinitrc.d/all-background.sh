#!/bin/bash

# Set the auto locker after user is idle for 'time' minutes
# corners options:
# 0: ignore corner
# +: start locker
# -: dont lock
# Order of corners is: top left, top right, bottom left, bottom right
#                      --------
#                      |1    2|
#                      |3    4|
#                      --------
#
#                           1234
xautolock -time 10 -corners ---- -locker "betterlockscreen -l dimblur" &

# Start the notification server
/usr/bin/dunst &
