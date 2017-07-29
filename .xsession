#!/bin/sh

echo "$DISPLAY" > "$HOME"/.xdisplay &

pulseaudio --start &

$(eval ssh-agent)

# if wasm't set automatically
xrdb -merge .Xresources

# Clipboard manager
parcellite &

# Set layout
myxkbmap && kbdd &

# Autohiding mouse cursos
# Bugs with awesome with sloppy focus
unclutter -idle 10 &

# Hotkey handling
xbindkeys &

# Turn on numlock
numlockx on &

# Spacefm daemon for automount
spacefm --daemon-mode &

# Compositing
compton -c -C  -I 0.2 -O 0.2 -f -i 0.92 -b

# Visual bell daemon
xvisbell &

xautolock -time 10 -locker 'xtrlock' &

# WM
exec awesome

