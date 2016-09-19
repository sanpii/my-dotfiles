# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -n "$DISPLAY" ]; then
    if which tmux 2>&1 >/dev/null; then
        test -z "$TMUX" && tmux new-session && exit
    fi
fi

# disable XON/XOFF flow control (^s/^q)
stty -ixon

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignorespace:ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=9000
export HISTFILESIZE=$HISTSIZE

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
history() {
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync() {
  builtin history -a
  HISTFILESIZE=$HISTFILESIZE
  builtin history -c
  builtin history -r
}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

empty_git_ps1()
{
    echo -n ''
}

set_prompt()
{
    local color_prompt

    _bash_history_sync

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    local force_color_prompt=yes

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    if [ -e /usr/share/git/completion/git-prompt.sh ]; then
        source /usr/share/git/completion/git-prompt.sh
        local git_ps1=__git_ps1
    else
        local git_ps1=empty_git_ps1
    fi

    PS1="\[\033[G\]"

    case "$TERM" in
        xterm*|rxvt*|screen*)
            PS1+="\[\e]0;\u@\h:\w\]"
        ;;
    esac

    if [ "$color_prompt" = yes ]; then
        PS1+="\[\033[01;37m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[32m\]\$($git_ps1)\[\e[0m\]"
        PS1+="\$(if [[ \$? != 0 ]]; then echo '\[\033[01;31m\]'; fi)\$\[\033[00m\] "
    else
        PS1+="\u@\h:\w\$($git_ps1)\$ "
    fi
}
export PROMPT_COMMAND='set_prompt'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi


    function _composercomplete {
        export COMP_LINE COMP_POINT COMP_WORDBREAKS;
        local -x COMPOSER_CWD=`pwd`
        local RESULT STATUS

        # Honour the COMPOSER_HOME variable if set
        local composer_dir=$COMPOSER_HOME
        if [ -z "$composer_dir" ]; then
            composer_dir=$HOME/.composer
        fi

        RESULT=`cd $composer_dir && composer depends _completion`;
        STATUS=$?;

        if [ $STATUS -ne 0 ]; then
            echo $RESULT;
            return $?;
        fi;

        local cur;
        _get_comp_words_by_ref -n : cur;

        COMPREPLY=(`compgen -W "$RESULT" -- $cur`);

        __ltrim_colon_completions "$cur";
    };
    complete -F _composercomplete cps;
fi

if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 ]; then
    startx
fi
