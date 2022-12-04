# possible changes regarding custom tag system will follow here

unalias cd &> /dev/null

unalias lsa lss lsl &> /dev/null

lsa()
{
	if [ -z "${LSSHORT+OFF}" ]
	then
		ls -gGAchN --time-style=+"%Y.%m.%d %H:%M:%S" "$@"
	else
		ls -ogGAN --color=always --time-style=+"%y.%m.%d" "$@" | awk '{$1=$2=$3=""; print $0}' | tail -n +2 | cut -c4-
	fi
}

alias cls='clear ; lsa'

# lss and lsl switch between the short and long modes of lsa and the prompt in the
# current terminal session; long is the default
# common lsa columns are replaced by yy.mm.dd and filename; SHORT_PS1 & LONG_PS1 replace PS1 prompt, with LONG_PS1 == PS1
SHORT_PS1="\[\033[01;34m\]\w\[\033[00m\]\$ "
LONG_PS1="${PS1}"
alias lss='LSSHORT="ON"; PROMPT_DIRTRIM=1; export PS1="${SHORT_PS1}"; cls'
alias lsl='unset LSSHORT; unset PROMPT_DIRTRIM; export PS1="${LONG_PS1}"; cls'

# This cd clears screen and lists all files on directory change;
# also, "cd +++" will be translated to "cd ../../.."
cdi()
{
	clear

	backward_symbol="+"

	symbols_count=$(awk -F"$backward_symbol" '{print NF-1}' <<< "${1}")
	
	if [ "$symbols_count" -ge "1" ] && [ -z "$(echo $1 | tr -d $backward_symbol)" ] && [ "$1" ]
	then
		current_dir="$(pwd)"
		
		for _ in $(seq $symbols_count); do cd ..; done
		
		export OLDPWD="$current_dir"
	else	
		cd $@
	fi

	lsa
}

alias cd='cdi'
