oldcat()
{
	while IFS='$\n' read -r line
	do
		echo -e "$line"
		sleep 0.1
	done
}
