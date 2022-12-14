#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

# Variables {{{
dmenu="dmenu \
		-i \
		${@} \
		"
script_name="Exit"
#script_name="$(echo $0 | awk -F '/' '{print $NF;}'):"
# }}}

choice=$(printf '%s\n' "Cancel" "Exit" "Lock" "Shutdown" "Reboot" \
	| $dmenu -p $script_name)

case $choice in
	Lock)
		slock
	;;
	Exit)
		killall -u $USER
	;;
	Shutdown)
		sudo shutdown -h now
	;;
	Reboot)
		sudo reboot
	;;
	Cancel)
		exit 0
	;;
	*)
		exit 1
	;;
esac
