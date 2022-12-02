#!/bin/bash
#   _   _
#  | | | |
#  | |_| |
#  |  _  |
#  |_| |_|
#
set -e

# Variables {{{
path="$HOME/.local/dev/hossein-lap/scripts"

dmenu="dmenu \
		-i \
		-l 0 \
		${@} \
		"
#script_name=$(echo $0 | awk -F '/' '{print $NF;}')
script_name="ScriptRunner"
# }}}

script=$(printf '%s\n' \
	"$(ls ${path}/dm-*.sh)" \
	| awk -F '/' '{print $NF;}' \
	| $dmenu -p "${script_name}")
		#~/.local/bin/dm-*.sh \

bash ${path}/$script "${@}"
