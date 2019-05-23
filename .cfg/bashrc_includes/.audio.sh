# set audio output device to hdmi or jack
alias audiohdmi='amixer cset numid=3 2'
alias audiojack='amixer cset numid=3 1'

# mute/unmute
alias audiomute='amixer -q sset PCM toggle'
