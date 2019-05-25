. ~/.config/bashrc_includes/.ls.sh

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
	
	\cd "$previous_dir" &> /dev/null
	\cd - &> /dev/null
	
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
	
	\cd "$previous_dir" &> /dev/null
	\cd - &> /dev/null
	
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


savefile="$HOME/.config/.savefile.txt"

save()
{
	rm -f $savefile
	touch $savefile
	while read -r line
	do
		echo $line >> $savefile
	done <<< $(\dirs -p -l | tail +2 | tac)
}

load()
{
	while \popd &> /dev/null; do :; done
	
	while read -r line
	do
		cd "$line"
		pushd . &> /dev/null
	done < "$savefile"
	
	dirs
}
