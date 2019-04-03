# This helps with compatibility
TERM=xterm-256color

# Don't do anything if non-interactive
[ -z "$PS1" ] && return

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function my_diff {
  if [ -x /usr/bin/wdiff ]; then
    if [ -x /usr/bin/colordiff ]; then
      /usr/bin/wdiff $1 $2 | /usr/bin/colordiff -U 6
    else
      /usr/bin/wdiff $1 $2
    fi
  else
    if [ -x /usr/bin/diff ]; then
      /usr/bin/diff -U 6 $1 $2
    else
      echo "No diff program found."
    fi
  fi
}

# Change to the absolute destination dir (dereference symlinks)
function ccd {
  pushd . > /dev/null 2>&1
  if [ -x $1 ]; then
    if [ $1 == ".." ]; then
      popd > /dev/null 2>&1
    else
      cd -P $1
    fi
  else
    echo "no dir given..."
    popd > /dev/null 2>&1
  fi
}

function setWindowTitle {
  if [ -x $1 ]; then
    echo -en "\003]0;@ - ${1}\007"
  fi
}

function reload {
  source ~/.bashrc
}

# A wrapper around vim, setting tmux window name
function vim {
  if [[ "$TMUX" != "" ]]; then
    tmux rename-window "vim"
  fi
  # I have a wrapper script around vim to set python path, etc.
  if [ -x ~/my_vim.py ]; then
    ~/my_vim.py "$@"
  else
    vim "$@"
  fi
  if [[ "$TMUX" != "" ]]; then
    tmux set-window-option automatic-rename "on" 1>/dev/null
  fi
}

# Better bash history across multiple sessions
HISTSIZE=200000
HISTFILESIZE=$(($HISTSIZE * 2))
HISTCONTROL=ignorespace:ignoredups
HISTTIMEFORMAT='%F %T '

_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}

history() {                  #5
  _bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

# append to the history file, don't overwrite it
shopt -s histappend

# reedit a history substitution line if it failed
shopt -s histreedit

# edit a recalled history line before executing
shopt -s histverify

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# useful aliases
alias grep='grep --color=auto -H'
alias fgrep='fgrep --color=auto -H'
alias egrep='egrep --color=auto -H'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=always'
# I'm always doing this one
alias Grep='grep --color=auto -H'

# Include any bash aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# bash completion (already enabled in /etc/bash.bashrc in most distros
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# Always forward agent
alias ssh='ssh -A'

# automatic gopath if present
if [ -d ~/go ]; then
  export GOPATH=~/go
  export PATH=$PATH:~/go/bin
fi

Black="\[\033[0;30m\]"
DarkGrey="\[\033[1;30m\]"
Blue="\[\033[0;34m\]"
LightBlue="\[\033[1;34m\]"
Green="\[\033[0;32m\]"
LightGreen="\[\033[1;32m\]"
Cyan="\[\033[0;36m\]"
LightCyan="\[\033[1;36m\]"
Red="\[\033[0;31m\]"
LightRed="\[\033[1;31m\]"
Purple="\[\033[0;35m\]"
LightPurple="\[\033[1;35m\]"
Brown="\[\033[0;33m\]"
Yellow="\[\033[1;33m\]"
LightGray="\[\033[0;37m\]"
White="\[\033[1;37m\]"

NO_COLOR="\[\033[0m\]"

function set_window_title {
  TITLEBAR=""
  local host_name=$(hostname -f)
  if [[ "${CUSTOM_TITLE}" != "" ]]; then
    TITLEBAR="\001\033]0;$CUSTOM_TITLE\007\002"
  else
    TITLEBAR="\001\033]0;@${host_name}\007\002"
  fi
  printf "$TITLEBAR"
}

### Emit a line of '----' with the current datetime in the center before executing each command
PS0="\$(printf -- '-%.s' \$(seq 1 \$((COLUMNS/2-13))) ; echo)  \D{%F %I:%M:%S %p}  \$(printf -- '-%.s' \$(seq 1 \$((COLUMNS/2-13))) ; echo)\n"

### Better PS1 than default. Includes chroot and timestamp in prompt
PS1="\$(set_window_title)${debian_chroot:+($Purple$debian_chroot$NO_COLOR)}$Green[X]\t @$Brown\H: $LightGray\W\$ $NO_COLOR"

# Any overrides you may want can go in ~/.bashrc_local
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi

