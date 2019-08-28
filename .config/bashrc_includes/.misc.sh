# not sure if necessary
alias sudo='sudo '

# generate people endlessly
alias crowd='while [ 1 ]; do rig | head -n 1; sleep 1; done'

# screensaver
alias ssr='cmatrix -ab -C green -u 2'

alias x='exit'

# shutdown with default value of 0
sdn()
{
	if [ $# -eq 0 ]
	then
		shutdown -t --no-wall 0
	fi
	
	if [ $# -eq 1 ]
	then
		shutdown -t --no-wall $1
	fi
}