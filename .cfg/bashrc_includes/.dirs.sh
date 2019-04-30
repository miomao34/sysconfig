. ~/.cfg/bashrc_includes/.ls.sh

unalias dirs &> /dev/null
unalias pushd &> /dev/null
unalias popd &> /dev/null

alias dirs='dirs -v | tail -n +2'

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
	popd 1> /dev/null
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
