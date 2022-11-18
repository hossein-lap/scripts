#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

# Variables {{{
[[ -z $1 ]] && bg='#ff7700' || bg="$1"
[[ -z $2 ]] && fg='#300a24' || fg="$2"
[[ -z $3 ]] && nf='#fdf6e3' || nf="$3"

dmenu="dmenu \
		-sb $bg -sf $fg \
		-nf $nf -nb $fg \
		-i -c -l 3 -g 2"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')
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
