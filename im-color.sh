#!/bin/bash
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              
set -e

if [[ ! $# == 4 ]]; then
	printf '%s\n' '$1 -> input' '$2 -> input color' \
		'$3 -> output color' '$4 -> percentage'
	#'$2 -> output' 
else
	cp -fv $1 $1.bak
	convert $1 -fuzz $4% -fill $3 -opaque $2 $1
fi
