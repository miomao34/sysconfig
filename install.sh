#!/usr/bin/bash

BACKUP_FOLDER="./$(date +%Y-%m-%d_%H.%M.%S)-backup"
installation_list_file="installation_list.txt"

cat "${installation_list}" | while read file
do
	echo -n "${file}: "
	if ! [[ -f "${file}" || -d "${file}" ]]
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

