#!/bin/bash
# For Optimus-Manager
if [[ -f "/usr/bin/prime-offload" ]]; then
    /usr/bin/prime-offload
fi

## xrandr commands for correct display resolution, gpu driver etc.
# xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
# xrandr --dpi 331 # This makes the menu bars larger, not entirely sure why

# TODO: change this to /etc/optimus-manager/xsetup-intel.sh or .../xsetup-nvidia.sh
# xrandr --output eDP-1 --mode "1920x1080"
# NOTE: without this, menu/dunst/dmenu are very large.
xrandr --dpi 96
autorandr --change
