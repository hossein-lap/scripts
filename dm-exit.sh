#!/bin/bash
#   _   _
#  | | | |
#  | |_| |
#  |  _  |
#  |_| |_|
#
set -e

bg='#ff0077'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 30"

action=$(printf '%s\n' "power-off" \
		"reboot" | $dmenu -p "$0")

case $action in
	power-off)
		shutdown -h now
	;;
	reboot)
		reboot
	;;
	*)
		fortune | $dmenu
	;;
esac
