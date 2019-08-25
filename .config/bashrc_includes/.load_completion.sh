#/usr/bin/env bash

savedir="$HOME/.config/dirsaves"

if [ ! -d $savedir ]
then
	mkdir $savedir
fi

cr=""
for line in $(ls $savedir)
do
	cr+="${line%*\.txt} "
done

complete -W "${cr// savefile/}" load save show
