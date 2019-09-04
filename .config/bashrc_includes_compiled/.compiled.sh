# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
shopt -s globstar

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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


# Custom aliases, stored in bare git repository
for filename in ~/.config/bashrc_includes/.*.sh ; do
	if [ -f "$filename" ];
	then
		 . "$filename"
	fi
done

# Private and local stuff like access tokens and work scripts, not to be stored in git
for filename in ~/.config/bashrc_includes_local/.*.sh ; do
	if [ -f "$filename" ];
	then
		 . "$filename"
	fi
done

# Not the cleanest solution, but will do - will act up
# only in version of config compiled into one file
if [ -f "./.colors.sh" ]
then
	. ./.colors.sh
fi

# golang variables
export GOPATH=${HOME}/go
export PATH=${HOME}/go/bin:$PATH
export GOBIN=$GOPATH/go/bin


alias bc='bc -q'

# possible changes regarding custom tag system will follow here

alias lsa='ls -gGach --time-style=+"%Y.%m.%d %H:%M:%S"'
alias lsl='ls -l'

alias cls='clear ; lsa'


unalias cd &> /dev/null

# This cd clears screen and lists all files on directory change;
# also, "cd +++" will translate to "cd ../../.."
cdi()
{
	clear

	backward_symbol="+"
	symbols_count=$(awk -F"$backward_symbol" '{print NF-1}' <<< "${1}")
	
	if [ "$symbols_count" -ge "1" ] && [ -z "${1//\+}" ] && [ "$1" ]
	then
		current_dir="$(pwd)"
		
		for i in $(eval echo "{1..$symbols_count}"); do cd ..; done
		
		export OLDPWD="$current_dir"
	else	
		cd "$@"
	fi
	lsa
}

alias cd='cdi'

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

complete -W "init status ensure prune version" dep

unalias dirs &> /dev/null
unalias pushd &> /dev/null
unalias popd &> /dev/null

dirsi()
{
	dirs $@ &> /dev/null
	\dirs -v | tail -n +2
}
alias dirs="dirsi"

pushdi()
{
	previous_dir="$OLDPWD"
	
	pushd $@ 1> /dev/null
	local retval=$?
	
	export OLDPWD="$previous_dir"
	
	dirs
	
	return $retval
}
alias pushd='pushdi'

popdi()
{
	previous_dir="$OLDPWD"

	popd $@ 1> /dev/null
	local retval=$?
	if [ $retval -eq 0 ]
	then
		clear
		dirs
		lsa
	fi
	
	export OLDPWD="$previous_dir"
	
	return $retval
}
alias popd='popdi'

peekdi()
{
	current_dir="$PWD"
	popd $@ 1> /dev/null
	local retval_pop=$?
	if [ $retval_pop -eq 0 ]
	then
		pushd .
		local retval_push=$?
		if [ $retval_push -eq 0 ]
		then
			\cd "$current_dir"
			\cd - &> /dev/null
			cls
		fi

		return $retval_push
	fi

	return $retval_pop
}

alias peekd='peekdi'

savefile_path="$HOME/.config/dirsaves/"
savefile_default_name="savefile.txt"

# Enables saving current directory stack to file in ~/.config/dirsaves
save()
{
	if [ ! -d $savefile_path ]
	then
		mkdir $savefile_path
	fi
	
	if [ $# -eq 1 ]
	then
		savefile="${savefile_path}${1}.txt"
	else
		savefile="${savefile_path}${savefile_default_name}"
	fi
	
	if [ -f $savefile ]; then
		rm -f $savefile_path$savefile_default_name
	fi
	
	touch $savefile
	echo -n > $savefile
	
	while read -r line
	do
		echo $line >> "$savefile"
	done <<< $(\dirs -p -l | tail +2 | tac)
	
	dirs_completion
}

# Enables loading from previously saved directory stack
load()
{
	if [ ! -d $savefile_path ]
	then
		mkdir $savefile_path
	fi
	
	if [ $# -eq 1 ]
	then
		if [ ! -f "${savefile_path}${1}.txt" ]; then
			echo "load: can't find savefile $1"
			return 1
		fi
		savefile="${savefile_path}${1}.txt"
	else
		savefile="$savefile_path$savefile_default_name"
	fi
	
	while \popd &> /dev/null; do :; done
	
	while read -r line
	do
		cd "$line"
		pushd . &> /dev/null
	done < "$savefile"
	
	dirs
	
	dirs_completion
}

# Shows saved directory stack
show()
{
	if [ $# -eq 0 ]
	then
		cat "$savefile_path$savefile_default_name"
	fi
	
	if [ $# -eq 1 ]
	then
		cat "${savefile_path}${1}.txt"
	fi
}

dirs_completion()
{
	if [ ! -d $savefile_path ]
	then
		mkdir $savefile_path
	fi

	cr=""
	for line in $(ls $savefile_path)
	do
		cr+="${line%*\.txt} "
	done

	complete -W "${cr// savefile/}" load save show
}

dirs_completion

alias purgedocker='docker rmi $(docker images -qf "dangling=true")'

# filename handling shamelessly stolen from
# https://askubuntu.com/questions/343727/filenames-with-spaces-breaking-for-loop-find-command

fixrights()
{
	find . -name '*.*' -print0 | 
	while IFS= read -r -d '' file; do
		
		[ -e "$file" ] || continue
		
		if [[ -d "$file" || ( -f "$file" && ( "$file" == *\.sh || "$file" == *\.py ) ) ]]
		then
			chmod 755 "$file"
		else
			if [[ -f "$file" && ( "$file" == *\.key ) ]]
			then
				chmod 000 "$file"
			else
				if [[ -f "$file" ]]
				then
					chmod 644 "$file"
				fi
			fi
		fi
		
	done
}

flasher ()
{
	while true
	do
		printf \\e[?5h
		sleep 0.1
		printf \\e[?5l
		read -s -n1 -t1 && break
	done
}

alias installed="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"


# not sure if necessary
alias sudo='sudo '

# generate people endlessly
alias crowd='while [ 1 ]; do rig | head -n 1; sleep 1; done'

# screensaver
alias ssr='cmatrix -ab -C green -u 2'

alias x='exit'

# shutdown with default value of 0
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

# get ssh connection stack
is_ssh()
{
	ssh_stack="$SSH_CONNECTION"
	if [ ! "$ssh_stack" ]
	then
		echo "current session is not a SSH session"
		return 0
	fi
	
	counter=0
	home=""
	for word in $ssh_stack
	do
		if [ ! $counter -eq 0 ]
		then
			home="$word"
		fi

		if [ ! $counter -eq 0 ] && [ $((counter%2)) -eq 0 ]
		then
			echo
		fi

		if [ $((counter%2)) -eq 0 ]
		then
			echo -en "${BLUE}$word${NC} @ "
		else
			echo -en "${YELLOW}$word${NC}"
		fi

		if [ $counter -eq 1 ]
		then
			echo -en "${GREEN} (HOME)${NC}"	
		fi

		counter=$(expr $counter + 1)
	done

	echo -e "${RED} (THIS MACHINE)${NC}"

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

alias shear="tee /dev/tty"

#!/bin/bash
tag()
{
	if [ $# -eq 0 ]
	then
		echo "Usage: tag <file>"
	fi

	if [ $# -eq 1 ]
	then
		 for a in $(IFS='\n' attr -ql $1)
		do
			echo $a : $(attr -qg $a $1)
		done
	fi
}

alias dupl='gnome-terminal & disown'
alias newterm='dupl ; sleep 0.2 ; exit'

lsa

