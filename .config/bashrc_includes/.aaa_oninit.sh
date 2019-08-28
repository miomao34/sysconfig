# Not the cleanest solution, but will do - will act up
# only in version of config compiled into one file
if [ -f "./.colors.sh" ]
then
	. ./.colors.sh
fi

# golang variables
export GOPATH=${HOME}/go
export PATH=${HOME}/go/bin:$PATH
export GOBIN=$GOPATH/go/bin

