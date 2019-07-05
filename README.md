# sysconfig
Basic settings for a fresh installation of linux

Direct installation script link: https://git.io/sysconfig_install_raspbian

### TODO:
* Add gnome/unity shortcuts - different branches?
* Support raspbian branch
	* Added audio output control device, volume control and mute/unmute - add a way to understand current volume and muted state
* Continue working on `tag()` function in `~/.cfg/bashrc_includes/.tag`
	* Add length-based indentation ([boop](https://www.google.com/search?q=bash+get+string+length))
	* Add attr-based parameters (-q, some flag just for values, some flag for "all files in dir w/ this tag" and "with this tag which holds this value")
	* If attr is not installed (`which attr`), trigger installation prompt
* `surge` command - you know what to do

### TODO Deprecated
* Disable fokken "press win to open start menu"
