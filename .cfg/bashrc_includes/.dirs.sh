. ~/.cfg/bashrc_includes/.ls.sh

unalias dirs &> /dev/null
unalias pushd &> /dev/null
unalias popd &> /dev/null

alias dirs='dirs -v | tail -n +2'

pushdi()
{
	pushd $@ 1> /dev/null
	local retval=$?
	dirs
	
	return $retval
}
alias pushd='pushdi'

popdi()
{
	popd $@ 1> /dev/null
	local retval=$?
	if [ $retval -eq 0 ]
	then
		clear
		dirs
		lsa
	fi
	
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
		local retval=$?
		\cd "$current_dir"
		\cd - &> /dev/null

		return $retval_push
	fi

	return $retval_pop
	}

alias peekd='peekdi'
