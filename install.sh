#!/usr/bin/bash

BACKUP_FOLDER="./$(date +%s)-backup"

# saving current settings if they exist
SAVE_LIST=(".bashrc" ".gitconfig" ".vimrc" ".moc")
for file in ${SAVE_LIST[@]}
do
	echo -n "trying ${file}... "
	if ! [[ -f "${file}" || -d "${file}" ]]
	then
		echo -n "not found..."
	else
		echo -n "found, backing up..."
		mv "~/${file}" "${BACKUP_FOLDER}/${file}"
		echo -n "backed up..."
	fi

	echo -n "linking..."
	ln -s "./${file}" "~/${file}"
	echo "done!"
done

