walli()
{
    usage="Usage:
	wall [options] [message]
	Write a message to all users.
	Options:
	-n, --nobanner          do not print banner
	-h, --help              display this help and exit
    "

    SHORT=nh
    LONG=nobanner,help

    PARSED=$(getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@")
    if [[ $? -ne 0 ]]; then
        echo "$usage"
        exit 2
    fi
    eval set -- "$PARSED"

    while true; do
        case "$1" in
            -n|--nobanner)
                n=y
                shift
                ;;
            -h|--help)
                echo "$usage"
                return 0
                ;;
            --)
                shift
                break
                ;;
            *)
               return  3
                ;;
        esac
    done

    ps -ef | grep " pts/" | awk '{print $6}' | sort -u > terminals_list.temp
    #ps -ef | grep " tty" | awk '{print $6}' | sort -u | grep -v "pts" >> terminals_list.temp
    if [ "$n" ]; then
        pre=""
        post=""
    else
        pre="-e \nBroadcast message from $(whoami)@$(hostname) ($(ps ax | grep "^$$" | awk '{ print $2 }')) ($(date +"%a %b %d %H:%M:%S %Y")):\n\n"
        post="\n"
    fi
    cat terminals_list.temp | while read TTY_TO; do echo $pre"$*"$post | tee /dev/$TTY_TO 1>/dev/null; done
    rm terminals_list.temp
}

alias wall='walli'
