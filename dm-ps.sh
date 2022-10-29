#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

bg='#ff2200'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 25"

list=$(ps --cols 135 ahxfo pid,%mem,%cpu,user,cmd  k %mem \
	| sed 's/  \\_ /  ├─ /' \
	| sed 's/|  /│  /g' \
	| sed 's/├─ -/├─ /' \
	| $dmenu -p 'kill:' \
	| awk '{print $1;}')

if [[ $list -eq 'PID' ]]; then
	fortune | sed 's/\t/    /g' \
		| $dmenu > /dev/null
	exit 0
else
	thesig=$(printf '%s\n' \
		"2    SIGINT    Interrupt   Terminate" \
		"3    SIGQUIT   Quit        Terminate with core dump" \
		"9    SIGKILL   Kill        Forced termination" \
		"15   SIGTERM   Terminate   Terminate" \
		| $dmenu -p 'Send signal:' \
		| awk '{print $1;}')

	if [ -z "${thesig}" ]; then
		kill="kill -s 15"
	else
		kill="kill -s $thesig"
	fi

	for i in $list
	do
		$kill "$i"
	done
fi
