# set audio output device to hdmi or jack
alias audiohdmi='amixer cset numid=3 2'
alias audiojack='amixer cset numid=3 1'

# mute/unmute
alias audiomute='amixer -q sset PCM toggle'

# increase/decrease volume by 5%
alias audioup='amixer -M sset PCM 5%+'
alias audiodown='amixer -M sset PCM 5%-'
