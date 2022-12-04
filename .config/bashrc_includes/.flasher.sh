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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
