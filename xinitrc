#!/bin/sh

export XDG_MENU_PREFIX="lxde-"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

exec awesome
