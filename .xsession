#!/bin/sh

echo "$DISPLAY" > "$HOME"/.xdisplay &
export DESKTOP_SESSION="gnome"  # for icons in Qt apps

pulseaudio --start &

eval $(ssh-agent)

# if wasm't set automatically
xrdb -merge .Xresources

# Set layout
myxkbmap && kbdd &

# Hotkey handling
xbindkeys &

# Turn on numlock
numlockx on &

# Spacefm daemon for automount
spacefm --daemon-mode &

# Compositing
compton -c -C  -I 0.2 -O 0.2 -f -b

xscreensaver -no-splash &

xset r rate 300
xset m 4

# WM
exec awesome

