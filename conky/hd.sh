#!/bin/sh

case "$1" in
  "used")
    field=3
  ;;
  "total")
    field=2
  ;;
  "perc")
    field=5
  ;;
esac

if [ "$1" = "perc" ]
then
  eval "df -h --total / /usr /var /tmp | grep total | awk '{print \$$field}'"
else
  eval "df -h --total / /usr /var /tmp | grep total | awk '{print \$$field \"iB\"}'"
fi

