#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

bg='#ffcc00'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 25"
notify="dunstify -a $(echo $0 | awk -F '/' '{print $NF;}')"

list=$(ps --cols 140 axfo pid,%mem,%cpu,user,cmd  k %mem \
	| sed 's/  \\_ /  ├─ /' \
	| sed 's/|  /│  /g' \
	| sed 's/├─ -/├─ /' \
	| $dmenu -p 'kill:' \
	| awk '{print $1;}')

if [[ $list -eq 'PID' ]]; then
	fortune | sed 's/\t/    /g' \
		| $dmenu > /dev/null
	$notify -u critical "Termination failed"
	exit 0
else
	thesig=$(printf '%s\n' \
		"9    SIGKILL   Kill       " \
		"2    SIGINT    Interrupt  " \
		"3    SIGQUIT   Quit       " \
		"15   SIGTERM   Terminate (Not Safe) " \
		| $dmenu -p 'Send signal:' \
		| awk '{print $1;}')

	if [ -z "${thesig}" ]; then
		kill="kill -s 2"
	else
		kill="kill -s $thesig"
	fi

	for i in $list
	do
		$kill "$i" \
			&& $notify -u normal "Process [${i}] killed with signal ${thesig}" \
			|| $notify -u critical "[${i}] Termination failed"
	done
fi
