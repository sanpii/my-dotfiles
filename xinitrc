#!/bin/sh

. "$HOME/.bash_aliases"
xrdb ~/.Xresources

export XDG_MENU_PREFIX="lxde-"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

setxkbmap -option ctrl:nocaps
if [ -s ~/.Xmodmap ]
then
    xmodmap ~/.Xmodmap
fi

if [ -e ~/.xinitrc.local ]
then
    ~/.xinitrc.local
fi

if [ -x /usr/bin/dunst ]
then
    killall notification-daemon &> /dev/null
    /usr/bin/dunst &
fi

if [ -x /usr/bin/parcellite ]
then
    /usr/bin/parcellite &
fi

if [ -x /usr/bin/owncloud ]
then
    /usr/bin/owncloud &
fi

if [ -x /usr/bin/urxvt ]
then
    /usr/bin/urxvt -name term-scratchpad &
fi

if [ -x /usr/bin/xautolock ]
then
    /usr/bin/xautolock -locker 'blur-lock' &
fi

exec i3 --force-xinerama
