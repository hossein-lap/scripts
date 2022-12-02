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
		-l 30 \
		-b \
		-i \
		${@} \
		"
prompt="FileManager"
#prompt="$(echo $0 | awk -F '/' '{print $NF;}')"
# }}}
list="ls -AXp --group-directories-first"

# check status {{{
stat_check () {
	if [[ -z "${dir}" ]]; then
		fortune | sed 's/\t/    /g' | ${dmenu} -p "$(pwd)/${dir}" > /dev/null
		exit 0
	fi
}
# }}}

dm_file () {
	file=$(printf '%s\n' './' '../'; $list)
		printf '%s\n' "$file" | $dmenu -p "$(pwd)"
}

while true
do
	dir="$(dm_file)"
	#oldpath="${dir}"
	#path="${path}${oldpath}"
	if [[ -d "$dir" ]]; then
		echo "$(pwd)/${dir}"
		cd "$dir"
	else
		ls -f "$dir"
	fi
	stat_check
done
