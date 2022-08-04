#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

bg='#ff6500'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg"

list=$(ps ax -o pid,user,cmd \
	| $dmenu -c -l 25 -p 'kill:' \
	| awk '{print $1};')

if [[ $list -eq 'PID' ]]; then
	fortune | sed 's/\t/    /g' \
		| $dmenu -c -l 30 > /dev/null
	exit 0
else
	for i in $list
	do
		kill "$i"
	done
fi
