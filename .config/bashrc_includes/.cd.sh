# possible changes regarding custom tag system will follow here
# must be included after .ls.sh

. ~/.config/bashrc_includes/.ls.sh

unalias cd &> /dev/null

cdi()
{
	backward_symbol="+"
	clear
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
