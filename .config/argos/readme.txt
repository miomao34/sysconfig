A plugin file may be named anything (it only needs to be executable), but if its name has the special form

NAME.POSITION.INTERVAL[+].EXTENSION
where

POSITION consists of an integer (optional) + one of l (left), c (center) or r (right), and
INTERVAL consists of an integer + one of s (seconds), m (minutes), h (hours) or d (days)
then

the dropdown menu button is placed in the panel at POSITION, and
the plugin is re-run and its output re-rendered every INTERVAL, and
if INTERVAL is followed by +, the plugin is additionally re-run each time the dropdown menu is opened.
POSITION may be omitted entirely (in which case the button is placed before all other buttons on the 
right-hand side of the panel) while INTERVAL can be left empty. For example, a script named plugin.10s.sh 
is updated every 10 seconds, the button belonging to plugin.1c..sh is positioned just right of the GNOME 
Shell clock, and plugin.l.1m.sh is displayed left of the "Activities" button and updated every minute.
