#!/bin/bash


## check function {{{
## To check the returned value of commend
#chkit () {
#	case $? in
#		0)
#			if [[ -z "$1" ]]; then 
#				notify-send -t 5000 -a '$1' -u normal \
#					"No argument specified"
#					exit 1
#			fi
#			
#			notify-send -t 5000 -a '$1' -u critical \
#				"Successfully finished"
#				exit 0
#			;;
#		*)
#			notify-send -t 10000 -a '$1' -u normal \
#				"Command failed"
#			runner
#			;;
#	esac
#}
## }}}
## Run a command {{{
#runner () {
#	$@
#	chkit $1
#}
## }}}

# Call the main function
count=1
while true
do
	"$@"
	printf '\n%s' "$count:"
	printf '%s\n' "   [End]"
	((count++))
	for i in `seq 10`
	do
		printf '%s' "."
		sleep 1
	done
	echo
done
