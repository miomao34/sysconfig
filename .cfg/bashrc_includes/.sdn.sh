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
