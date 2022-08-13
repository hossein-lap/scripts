#!/bin/bash
#   _   _
#  | | | |
#  | |_| |
#  |  _  |
#  |_| |_|
#
set -e

bg='#ccaa77'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 30"

script=$(printf '%s\n' \
		~/.local/dev/hossein-lap/scripts/dm-*.sh \
	| awk -F '/' '{print $NF;}' \
	| $dmenu -p "dm-srun.sh:")
		#~/.local/bin/dm-*.sh \

bash ~/.local/dev/hossein-lap/scripts/$script
