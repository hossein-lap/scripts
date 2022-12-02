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
		-l 25 \
		${@} \
		"
#prompt="$(echo $0 | awk -F '/' '{print $NF;}'):"
prompt="Kill"

mytitle="Some title"
echo -e '\033k'$mytitle'\033\\'
# }}}
# sent notification {{{
notify() {
	case $2 in
		1)
			mode=low
			;;
		2)
			mode=normal
			;;
		3)
			mode=critical
			;;
		*)
			mode=normal
			;;
	esac

	notify-send -a ${prompt} -i xfce-mount -u $mode "${1}"
}
# }}}

list=$( \
	ps --cols 140 axfo pid,%mem,%cpu,user,cmd  k %mem \
		| $dmenu -p "${prompt}" \
		| awk '{print $1;}'

#		| sed 's/  \\_ /  ├─ /' \
#		| sed 's/|  /│  /g' \
#		| sed 's/├─ -/├─ /' \

	)

if [[ $list -eq 'PID' ]] || [[ -z $list ]]; then
	notify 'Canceled' 1
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
			&& notify "Process [${i}] killed (signal ${thesig})" \
			|| notify "[${i}] Termination failed" 3
	done
fi
