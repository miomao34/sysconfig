#!/bin/bash
tag()
{
	if [ $# -eq 0 ]
	then
		echo "Usage: tag <file>"
	fi

	if [ $# -eq 1 ]
	then
		for a in $(attr -ql $1)
		do
			echo $a : $(attr -qg $a $1)
		done
	fi
}
