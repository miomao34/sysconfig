# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

NC='\033[0m' # No Color

BLACK='\033[0;30m'
DRED='\033[0;31m'
DGREEN='\033[0;32m'
ORANGE='\033[0;33m'
	DYELLOW='\033[0;33m'
DBLUE='\033[0;34m'
DPURPLE='\033[0;35m'
DCYAN='\033[0;36m'
LGRAY='\033[0;37m'

DGRAY='\033[1;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsa='ls -gGach --time-style=long-iso'
alias lsl='ls -l'
alias x='exit'

cdi()
{
	clear
	cd "$@"
	lsa
}
alias cd='cdi'

sdn()
{
	if [ $# -eq 0 ]
	then
		shutdown -t --no-wall 0
	fi
	
	if [ $# -eq 1 ]
	then
		shutdown -t --no-wall $1
	fi
}
randtext()
{
	if [ $# -eq 0 ]
	then
		echo "Usage: randtext <size>"
	fi
	
	if [ $# -eq 1 ]
	then
		base64 /dev/urandom | head -c $1
		echo ""
	fi
}

alias dirs='dirs -v'
#alias fixrights='chmod 644 * ; chmod 755 */'
fixrights()
{
	if [ -f ]
	then
		chmod 644 *
	fi
	
	if [ -f *.sh ]
	then
		chmod 755 *.sh
	fi
	
	if [ -f *.deb ]
	then
		chmod 755 *.deb
	fi
	
#	if [ -d ]
#	then
#		chmod 755 */
#		for D in */; do
#		if [ -d "${D}" ]; then
#			cd ${D}
#			fixrights
#			cd ..
#		fi
#		done
#	fi
	
	for D in $(find . -mindepth 1 -maxdepth 1 -type d);
	do
		chmod 755 "$D"
		cd "$D"
		fixrights
		cd ..
	done
}

alias purgedocker='docker rmi $(docker images -qf "dangling=true")'

alias bc='bc -q'
alias settingsconfig='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
complete -W "add branch checkout commit config pull push status" settingsconfig

alias zg='cd ~/go/src/gitlab.com/coiiot/'

alias cls='clear ; lsa'

alias crowd='while [ 1 ]; do rig | head -n 1; sleep 1; done'
alias ssr='cmatrix -ab -C green -u 2'
alias dupl='gnome-terminal & disown'
alias newterm='dupl ; sleep 0.2 ; exit'

# TEMP
alias quicktest='echo "" ; ./ptest.sh -v --color=always | grep --color=never "ADMIN\|GetTopics" ; echo ""'
alias getqueue='notify-send "Queue status:" "$(curl -s http://videod.mail.cloud.devmail.ru/result/canteen | jq ".queues[0,1].size")"'

alias sudo='sudo '

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
fi

export GITLAB_ACCESS_TOKEN=iyKDxyck1gASpcqZMUMa

export GOPATH=${HOME}/go
export PATH=${HOME}/go/bin:$PATH
export GOBIN=$GOPATH/go/bin

lsa
# xdotool key 'ctrl+KP_Subtract'
