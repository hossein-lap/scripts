#!/bin/bash
#  _  _
# | || | github: hossein-lap
# | __ | email:  hosteam01@gmail.com
# |_||_| matrix: hosaidenpwd:matrix.org
#
set -e

mess=$(ping -c 1 1.1.1.1 \
	| grep bytes \
	| grep -v PING \
	| awk -F '=' '{print $NF}' \
	| grep '^[0-9]')

if [[ $(echo $mess | awk '{print $NF}') -eq 'ms' ]]; then
	printf '%s' "${mess}" | awk '{print $1}'

else
	printf '%s' '-'
fi

#sleep 2
