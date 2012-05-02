#!/bin/sh

export XDG_MENU_PREFIX="lxde-"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

if [ -x ~/.applications/bin/statnot ]; then
    killall notification-daemon &> /dev/null
    ~/.applications/bin/statnot ~/.statnot/config.py &
fi;

if [ -x /usr/bin/VBoxClient ]; then
    /usr/bin/VBoxClient --clipboard &
fi;

if [ -x /usr/bin/owncloud ]; then
    /usr/bin/owncloud &
fi;

if [ -x /usr/bin/parcellite ]; then
    /usr/bin/parcellite &
fi;

if [ -x /usr/bin/davmail ]; then
    /usr/bin/davmail &
fi;

if [ -x /usr/bin/icedove ]; then
    /usr/bin/icedove &
fi;

if [ -x /usr/bin/x-www-browser ]; then
    /usr/bin/x-www-browser &
fi;

if [ -x /usr/bin/x-terminal-emulator ]; then
    /usr/bin/x-terminal-emulator &
fi;

exec i3 --force-xinerama

