#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

# Variables {{{
[[ -z $1 ]] && bg='#d33682' || bg="$1"
[[ -z $2 ]] && fg='#300a24' || fg="$2"
[[ -z $3 ]] && nf='#fdf6e3' || nf="$3"

dmenu="dmenu \
		-sb $bg -sf $fg \
		-nf $nf -nb $fg \
		-i -c -l 25 -g 1"
prompt=$(echo $0 | awk -F '/' '{print $NF;}')
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

list=$(ps --cols 140 axfo pid,%mem,%cpu,user,cmd  k %mem \
	| sed 's/  \\_ /  ├─ /' \
	| sed 's/|  /│  /g' \
	| sed 's/├─ -/├─ /' \
	| $dmenu -p "${prompt}" \
	| awk '{print $1;}')

if [[ $list -eq 'PID' ]]; then
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
