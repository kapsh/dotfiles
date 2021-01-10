#!/bin/sh

echo "$DISPLAY" > "$HOME"/.xdisplay &
export DESKTOP_SESSION="gnome"  # for icons in Qt apps

# Set layout
"${HOME}"/bin/myxkbmap && kbdd &

# Turn on numlock
numlockx on &

# Compositing
picom -b &

xscreensaver -no-splash &

xset r rate 250
xset m 10

