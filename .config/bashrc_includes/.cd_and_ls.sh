# possible changes regarding custom tag system will follow here

alias lsa='ls -gGach -N --time-style=+"%Y.%m.%d %H:%M:%S"'
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
