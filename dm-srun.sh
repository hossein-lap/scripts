#!/bin/bash
#   _   _
#  | | | |
#  | |_| |
#  |  _  |
#  |_| |_|
#
set -e

# Variables {{{
[[ -z $1 ]] && bg='#ff7700' || bg="$1"
[[ -z $2 ]] && fg='#300a24' || fg="$2"
[[ -z $3 ]] && nf='#fdf6e3' || nf="$3"

dmenu="dmenu \
		-sb $bg -sf $fg \
		-nf $nf -nb $fg \
		-i -c -l 6 -g 2"
script_name=$(echo $0 | awk -F '/' '{print $NF;}')
# }}}

script=$(printf '%s\n' \
		~/.local/dev/hossein-lap/scripts/dm-*.sh \
	| awk -F '/' '{print $NF;}' \
	| $dmenu -p "${script_name}")
		#~/.local/bin/dm-*.sh \

bash ~/.local/dev/hossein-lap/scripts/$script
