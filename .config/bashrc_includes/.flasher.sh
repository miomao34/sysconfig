flasher ()
{
	while true
	do
		printf \\e[?5h
		sleep 0.1
		printf \\e[?5l
		read -s -n1 -t1 && break
	done
}
