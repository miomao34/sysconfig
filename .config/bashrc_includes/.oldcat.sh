oldcat()
{
	while IFS='$\n' read -r line
	do
		echo -e "$line"
		sleep 0.1
	done
}

alias oldclear='for i in $(seq $(($LINES-1))); do echo; done | oldcat'
