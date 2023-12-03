# sysconfig
Basic settings for a fresh linux installation 

On install, the settings listed in `backup.txt` will be linked to home.

## Install:
* Clone this repo: `git clone git@github.com:miomao34/sysconfig.git`
* `cd sysconfig`
* Review `backup.txt` for the settings you wish to install
* `./install.sh`

To revert the changes, run `./restore.sh`

## TODO:
[x] Rewrite readme
[x] Add installation/deinstallation scripts
[ ] Cleanup `.config`
[ ] Add a link for regolith i3 config

## Deprecated TODO:
* Support raspbian branch
* Continue working on `tag()` function in `~/.cfg/bashrc_includes/.tag`
	* Add length-based indentation ([boop](https://www.google.com/search?q=bash+get+string+length))
	* Add attr-based parameters (-q, some flag just for values, some flag for "all files in dir w/ this tag" and "with this tag which holds this value")
	* If attr is not installed (`which attr`), trigger installation prompt
* `surge` command - you know what to do
