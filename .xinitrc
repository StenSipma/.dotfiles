#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Run local xinitrc commands and programs
if [ -d ~/.config/xinitrc.d ] ; then
	# Commands for all machines, files start with all-[name].sh
	for f in ~/.config/xinitrc.d/all-?*.sh; do
		[ -x "$f" ] && . "$f"
	done

	# Commands specific to this machine, files start with [hostname]-[name].sh
	for f in ~/.config/xinitrc.d/$(cat /etc/hostname)-?*.sh; do
		[ -x "$f" ] && . "$f"
	done

	unset f
fi

# Start the XMonad window manager
exec xmonad
