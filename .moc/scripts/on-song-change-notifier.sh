#!/usr/bin/bash

# "now playing" notifications
on_song_change_notify () {
    filepath="$1"
    filename="${filepath##*\/}"
    containing_folder="${filepath%\/*}"
    
    # looking for icon: if cover.* not found, then looking for subdirecrories; if still not found, then going up a level untill an image is found
    icon="$(find "${containing_folder}" -maxdepth 1 -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' | grep -i cover | head -n 1)"
    icon="${icon:-$(find "${containing_folder}" -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' | head -n 1)}"

    while [ -z "$icon" ] && [ "${containing_folder}" != "/" ]; do
        icon="$(find ${containing_folder} -maxdepth 1 -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' | head -n 1)"
        containing_folder="${containing_folder%\/*}"
    done
    
    length="$2"

    notify-send -i "${icon:-\ }" -r 80085 -t 3200 "${filename}" "${length}"
}


on_song_change_notify "$1" "$2"
