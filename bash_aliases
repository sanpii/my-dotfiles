#!/bin/sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Enable simple aliases to be sudo'ed. ("sudone"?)
# http://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias sudo='sudo ';

# some more ls aliases
alias c='bc -l'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias sf='php app/console'
alias ack='ack-grep'
alias t='~/.todo/cli/todo.sh'
alias wt='~/.todo/cli/todo.sh -d ~/.todo-work.cfg'
alias ht='~/.todo/cli/todo.sh -d ~/.todo-home.cfg'

alias irc='ssh -t irc.homecomputing.fr "tmux attach-session -t irc"'

TORRENT='ssh -t cuddles "tmux attach-session -t rtorrent"'
alias torrent=$TORRENT

torrent_add() {
    for torrent in "$@"; do
        if [[ -f $torrent ]]; then
            scp -q "$torrent" cuddles:/media/data/torrent/watch
        else
            ssh -qt cuddles "cd /media/data/torrent/watch && wget --no-check-certificate -q $torrent"
        fi

        if [[ $? -eq 0 ]]; then
            echo "'$torrent' added"
        else
            echo "'$torrent' failed"
        fi
    done;
}

export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

export MAIL=~/Maildir

export PATH=$HOME/.local/bin:$HOME/bin:$PATH

export LESS='--quit-if-one-screen --no-init --ignore-case --RAW-CONTROL-CHARS --quiet --dumb'

export EDITOR=vim
