#!/bin/sh

echo "$DISPLAY" > "$HOME"/.xdisplay &

pulseaudio --start &

# if wasm't set automatically
xrdb -merge .Xresources

# Yandex-disk client
yandex-disk start

# Clipboard manager
parcellite &

# Per-window layout daemon
kbdd &

# Autohiding mouse cursos
# Bugs with awesome with sloppy focus
unclutter -idle 10 &

# Hotkey handling
xbindkeys &

# Turn on numlock
numlockx on &

# Spacefm daemon for automount
spacefm --daemon-mode &

# (moved to rc.lua)
# Conky
#conky &
# Setting keyboard layout
#myxkbmap &
# Workaround for wibox and russian layout
# fuck_wibox &

# Compositing
compton -c -C  -I 0.1 -O 0.1 -f -i 0.95 -b

# Visual bell daemon
xvisbell &

# WM
exec awesome

