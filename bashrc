# This helps with compatibility
TERM=xterm-256color

# Don't do anything if non-interactive
[ -z "$PS1" ] && return 

function my_diff {
  if [ -x /usr/bin/wdiff ]; then
    if [ -x /usr/bin/colordiff ]; then
      /usr/bin/wdiff $1 $2 | /usr/bin/colordiff -U 6
    fi
  else
    if [ -x /usr/bin/diff ]; then
      /usr/bin/diff -U 6 $1 $2
    else
      echo "No diff program found."
    fi
  fi
}

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

# Better bash history across multiple sessions
HISTSIZE=100000
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

# Always forward agent
alias ssh='ssh -A'

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

PS1="$Green[⚡]\t @$Brown\H: $LightGray\W\$ $NO_COLOR"
