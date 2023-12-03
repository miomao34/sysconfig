# not sure if necessary
alias sudo='sudo '

# generate people endlessly
alias crowd='while [ 1 ]; do rig | head -n 1; sleep 1; done'

# screensaver
alias ssr='cmatrix -ab -C green -u 2'

alias x='exit'

alias агсл="gsettings set org.gnome.desktop.input-sources current 0 && fuck"

# silent ffplay
alias ffsilent="ffplay -hide_banner -nodisp -autoexit -loglevel error"

# wait for a keypress
alias waitchar="read -n 1 k <&1"

# cat several files side-by-side
twocat()
{
	pr -w $COLUMNS -mt $@
}

# cli calculator
alias bc='bc -qil'

# cli calculator but inline
cb()
{
	echo "$@" | bc
}

# seek text entries in folder
alias seek='grep -rn'

# silent start
runsilent()
{
	$@ &> /dev/null & disown
}

# shutdown with default value of 0
sdn()
{
	shutdown -t --no-wall ${1:-0}
}

# fix rights after copying from a hard drive
fixrights()
{
	find . -type d | while read -r line
	do
		chmod 0755 "${line}"
	done
	find . -type f | while read -r file
	do
		chmod 0664 "${file}"
	done

	#find . -type d -print0 | xargs -0 chmod 0775
	#find . -type f -print0 | xargs -0 chmod 0664
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
