#!/usr/bin/bash

BACKUP_FOLDER="./$(date +%Y-%m-%d_%H.%M.%S)-backup"
installation_list_file="installation_list.txt"

mkdir -p "$BACKUP_FOLDER"

cat "${installation_list_file}" | grep "[a-z]" | while read file
do
	echo -n "${file}: "
	if [[ ! -e "~/${file}" ]]
	then
		echo -n "not found - "
	else
		echo -n "found - "
		mv "~/${file}" "${BACKUP_FOLDER}/${file}"
		echo -n "backed up - "
	fi

	echo -n "linking - "
	ln -s "./${file}" "~/${file}"
	echo "done!"
done

