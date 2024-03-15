#!/usr/bin/env bash

tmp="$(basename $(dirname $(pwd)))/$(basename $(pwd))"
name=$(echo ${tmp} | tr . _)

check=$(tmux ls 2>/dev/null | grep -c "${name}")

if [ "${check}" = '0' ]; then
	echo -ne "\033]0;${name}\007"
	tmux new -s ${name} ${@} 2>/dev/null
else
	echo -ne "\033]0;${name}\007"
	tmux att -t "${name}" ${@} 2>/dev/null
fi
