# not sure if necessary
alias sudo='sudo '

# generate people endlessly
alias crowd='while [ 1 ]; do rig | head -n 1; sleep 1; done'

# screensaver
alias ssr='cmatrix -ab -C green -u 2'

alias x='exit'

# cat several files side-by-side
twocat()
{
	pr -w $COLUMNS -mt $@
}

alias bc='bc -qil'

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
