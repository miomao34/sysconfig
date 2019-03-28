#alias fixrights='chmod 644 * ; chmod 755 */'

fixrights()
{
	if [ -f ]
	then
		chmod 644 *
	fi
	
	if [ -f *.sh ]
	then
		chmod 755 *.sh
	fi
	
	if [ -f *.deb ]
	then
		chmod 755 *.deb
	fi
	
#	if [ -d ]
#	then
#		chmod 755 */
#		for D in */; do
#		if [ -d "${D}" ]; then
#			cd ${D}
#			fixrights
#			cd ..
#		fi
#		done
#	fi
	
	for D in $(find . -mindepth 1 -maxdepth 1 -type d);
	do
		chmod 755 "$D"
		cd "$D"
		fixrights
		cd ..
	done
}
