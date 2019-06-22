#/usr/bin/env bash

savedir="$HOME/.config/dirsaves"

cr=""
for line in $(ls $savedir)
do
	cr+="${line%*\.txt} "
done

complete -W "$cr" load save show
