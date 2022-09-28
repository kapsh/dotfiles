#!/bin/sh

echo "$DISPLAY" > "$HOME"/.xdisplay &
export DESKTOP_SESSION="gnome"  # for icons in Qt apps

# export QT_QPA_PLATFORMTHEME=qt5ct # TODO breaks tray icons

"${HOME}"/bin/myxkbmap &

numlockx on &

picom -b &

xscreensaver -no-splash &

pipewire >/tmp/pipewire.log &

