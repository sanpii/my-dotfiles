#!/bin/sh

if [ -x ~/.applications/bin/statnot ]; then
    killall notification-daemon &> /dev/null
    ~/.applications/bin/statnot ~/.statnot/config.py &
fi;

if [ -x /usr/bin/VBoxClient ]; then
    /usr/bin/VBoxClient --clipboard &
fi;

exec i3

