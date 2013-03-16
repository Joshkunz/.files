CLICOLOR=1
LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

##  PATH   ##
# brew is corrupting my python bin path
PATH="/usr/local/share/python:$PATH"

# Some more manual path suff
PATH="/usr/local/bin:/usr/local/sbin/:$PATH"

# Add my binfiles to the path
PATH="$HOME/bin:$PATH"

## DEFAULTS ##
EDITOR=vim
LANG="en_US.UTF-8"
PS1="[\e[0;36m\#\e[m] \T \e[1;31m\u\e[m:\w\n\$ "

## Song Formatting ##
MPC_FMT="'[[%artist% - ]%title%[ (on %album%)]]|[%file%]'"

##  ALIASES  ##

alias ls='ls -GFh'
alias la='ls -a'
alias ll='ls -la'

alias less='less -R'
alias grep='grep --color'

alias weechat='weechat-curses'
alias irc='weechat'

alias mpc="mpc -f $MPC_FMT"

##  FUNCTIONS   ##

# grep the path for something
function psearch {
    echo $PATH | tr ':' '\0' | xargs -0 ls | grep -Ei $1
}
