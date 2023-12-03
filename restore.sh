#!/usr/bin/env bash

# rise up and shine, we're gonna see the queen
BACKUP_DIR=$(find . -mindepth 1 -maxdepth 1 -d | grep backup\- | sort | tail -n 1)
if ! [ "${BACKUP_DIR}" ]
then
	echo "no previous backups found"
	exit
fi
exit
# saving current settings if they exist
BACKUP_LIST=()
cat backup.txt | while read -r line
do
	BACKUP_LUST+=("${line}")
done

FOUND=()
NOT_FOUND=()
NOT_SYMLINK=()

echo "restoring..."
for item in "${BACKUP_LIST[@]}"
do
	if ! [[ -L "${item}" ]]
	then
		NOT_SYMLINK+=("${item}")
		continue
	fi
	
	if ! [[ -f "${item}" || -d "${item}" ]]
	then
		NOT_FOUND+=("${item}")
		continue
	fi

	FOUND+=("${item}")
	#mkdir -p "${BACKUP_DIR}/${item}" && mv "~/${item}" "${BACKUP_DIR}/${item}"
done

echo "backed up;"
echo "      FOUND:" "${FOUND[@]}"
echo "  NOT FOUND:" "${NOT_FOUND[@]}"
echo "NOT SYMLINK:" "${NOT_SYMLINK[@]}"

for item in "${BACKUP_LIST[@]}"
do
	#mkdir -p "~/${item}"
	#ln -s "${item}" "~/${item}"
done

#echo "installed"
