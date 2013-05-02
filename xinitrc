#!/bin/sh

. "$HOME/.bash_aliases"

export XDG_MENU_PREFIX="lxde-"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

functiont exist()
{
    type -P $1 > /dev/null
}

if exist dunst; then
    killall notification-daemon &> /dev/null
    dunst &
fi;

if exist davmail; then
    davmail &
fi;

if exist parcellite; then
    parcellite &
fi;

if exist git-annex; then
    git-annex assistant --austart &
fi;

if exist icedove; then
    icedove &
elif exist thunderbird; then
    thunderbird &
fi;

if exist x-www-browser; then
    x-www-browser &
fi;

if exist x-terminal-emulator; then
    xirc &
    x-terminal-emulator -name term-scratchpad &
fi;

if exist xautolock; then
    xautolock -locker 'i3lock -t -i ~/.config/i3/lockscreen.png' &
fi;

exec i3 --force-xinerama
