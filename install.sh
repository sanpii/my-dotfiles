#!/bin/sh

home=$HOME;
cwd=$(dirname $0);
scriptname=$(basename $0);

for file in *; do
  if [ "$file" != "$scriptname" ]; then
    ln -s "$cwd/$file" "$home/.$file"
  fi
done;

