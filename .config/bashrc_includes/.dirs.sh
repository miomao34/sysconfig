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
	
	source $HOME/.config/bashrc_includes/.load_completion.sh
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
	
	source $HOME/.config/bashrc_includes/.load_completion.sh
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
