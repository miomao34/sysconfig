#!/usr/bin/bash

# "now playing" notifications
on_song_change_notify () {
    filepath="$1"
    filename="${filepath##*\/}"
    containing_folder="${filepath%\/*}"
    
    icon="$(find "${containing_folder}" -maxdepth 1 -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' | grep -i cover | head -n 1)"
    icon="${icon:-$(find "${containing_folder}" -maxdepth 1 -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' | head -n 1)}"
    #icon="$(find "${containing_folder}" -maxdepth 1 -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' | head -n 1)"
    
    length="$2"

    notify-send -i "${icon:-\ }" -r 80085 -t 3200 "${filename}" "${length}"
}


on_song_change_notify "$1" "$2"
