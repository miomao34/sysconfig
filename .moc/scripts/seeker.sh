# implements youtube-like seeking, where pressing 1(f1) forces the playback to jump to 10%, 4(f4) to 40% and so on

seeker () {
    # $1 - the ratio number, 1 for 10%, 7 for 70% and so on

    seek_to=$(($1*10))

    #echo "$2 >> $seek_to/$1"
    mocp -j $seek_to%
}

seeker $1
