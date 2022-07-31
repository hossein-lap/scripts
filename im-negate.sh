#!/bin/bash
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              
set -e

for i in "$@"
do
	cp -fv $i $i.bak
	convert $i -channel RGB -negate $i
done
