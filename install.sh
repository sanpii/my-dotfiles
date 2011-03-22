#!/bin/sh

cwd=`pwd`;
home=$HOME;

for file in *; do
  if [ "$cwd/$file" != "$0" ]; then
    echo ln -s "$cwd/$file" "$home/.$file"
  fi
done;

