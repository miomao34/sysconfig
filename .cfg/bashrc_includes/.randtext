randtext()
{
	if [ $# -eq 0 ]
	then
		echo "Usage: randtext <size>"
	fi
	
	if [ $# -eq 1 ]
	then
		base64 /dev/urandom | head -c $1
		echo ""
	fi
}
