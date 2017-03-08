#!/bin/sh

if [ -s /usr/bin/ck-launch-session ]
then
    exec ck-launch-session dbus-launch --sh-syntax --exit-with-session ~/.xstart
else
    exec ~/.xstart
fi
