#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              

#!/bin/bash

if [[ -z "${1}" ]]; then
    echo 'No command specified'
    exit 5
fi

"$@" | nc termbin.com 9999

if [[ ! -z $? ]]; then
	printf '%s\n' "[raw:]" "$theurl" \
		"" "[with syntax]:" \
		"`echo $theurl | sed 's/\/\//\/\/l./'`"
fi
