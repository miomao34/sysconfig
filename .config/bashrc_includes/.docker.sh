alias purgedocker='docker rmi $(docker images -qf dangling=true) | sed -e "s/^.*\://" | shear >> ~/Documents/misc/dcimg.txt'
