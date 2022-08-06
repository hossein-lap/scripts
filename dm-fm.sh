#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

bg='#55aa00'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 30"
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
		printf '%s\n' "$file" | $dmenu -p "[$(pwd)]"
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
