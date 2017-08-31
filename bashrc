# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

if [ -n "$DISPLAY" -a -z "$TOR" ]
then
    if which tmux 2>&1 >/dev/null; then
        test -z "$TMUX" && tmux new-session && exit
    fi
fi

for file in ~/.bashrc.d/*;
do
    source "$file"
done
