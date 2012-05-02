#!/bin/sh

home=$HOME;
scriptname=$(basename $0);
cwd=$(dirname $0);
if [ "$cwd" = "." ]; then
    cwd=$(pwd);
fi

for file in *; do
    if [ "$file" != "$scriptname" ]; then
        if [ -h "$home/.$file" ]; then
            rm "$home/.$file";
        fi;
        if [ ! -e "$home/.$file" ]; then
            ln -s "$cwd/$file" "$home/.$file";
        else
            echo "$home/.$file existe déjà";
        fi;
    fi;
done;

touch $home/.gitconfig.obs
touch $home/.vim/obs.vim

