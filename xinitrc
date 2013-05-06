#!/bin/sh

. "$HOME/.bash_aliases"

export XDG_MENU_PREFIX="lxde-"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

if [ -x /usr/bin/dunst ]; then
    killall notification-daemon &> /dev/null
    /usr/bin/dunst &
fi;

if [ -x /usr/bin/davmail ]; then
    /usr/bin/davmail &
fi;

if [ -x /usr/bin/parcellite ]; then
    /usr/bin/parcellite &
fi;

if [ -x /usr/bin/git-annex ]; then
    /usr/bin/git-annex assistant --austart &
fi;

if [ -x /usr/bin/hamster-time-tracker]; then
    /usr/bin/hamster-time-tracker &
fi;

if [ -x /usr/bin/icedove ]; then
    /usr/bin/icedove &
elif [ -x /usr/bin/thunderbird ]; then
    /usr/bin/thunderbird &
fi;

if [ -x /usr/bin/x-www-browser ]; then
    /usr/bin/x-www-browser &
fi;

if [ -x /usr/bin/x-terminal-emulator ]; then
    xirc &
    /usr/bin/x-terminal-emulator -name term-scratchpad &
fi;

if [ -x /usr/bin/xautolock ]; then
    /usr/bin/xautolock -locker '/usr/bin/i3lock -t -i ~/.config/i3/lockscreen.png' &
fi;

exec i3 --force-xinerama
