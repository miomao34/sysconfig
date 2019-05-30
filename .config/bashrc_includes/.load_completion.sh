#/usr/bin/env bash

savedir="$HOME/.config/dirsaves"

_load_completions()
{
	# for line in $(ls -a $savedir | awk -F[\.] '{printf "%s ", $2}' | grep [a-zA-Z1-9])
	#do
	#	COMPREPLY+="$line "
	#done
	COMPREPLY+=$(ls -a $savedir | awk -F[\.] '{printf "%s ", $2}')
	COMPREPLY=($(compgen -W $COMPREPLY "${COMP_WORDS[1]}"))
}
complete -F _load_completions load
