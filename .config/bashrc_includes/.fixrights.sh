# filename handling shamelessly stolen from
# https://askubuntu.com/questions/343727/filenames-with-spaces-breaking-for-loop-find-command

fixrights()
{
	find . -name '*.*' -print0 | 
	while IFS= read -r -d '' file; do
		
		[ -e "$file" ] || continue
		
		if [[ -d "$file" || ( -f "$file" && ( "$file" == *\.sh || "$file" == *\.py ) ) ]]
		then
			chmod 755 "$file"
		else
			if [[ -f "$file" && ( "$file" == *\.key ) ]]
			then
				chmod 000 "$file"
			else
				if [[ -f "$file" ]]
				then
					chmod 644 "$file"
				fi
			fi
		fi
		
	done
}
