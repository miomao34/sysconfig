# possible changes regarding custom tag system will follow here
# must be included after .ls.sh

. ~/.config/bashrc_includes/.ls.sh

unalias cd &> /dev/null

cdi()
{
	clear
	cd "$@"
	lsa
}

alias cd='cdi'
