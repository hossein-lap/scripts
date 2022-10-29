#!/bin/bash

shadow_border_ts () {
	if [[ -z "$1" ]]; then
		printf '%s\n' "No image name or argument is specified :/"
		exit 1
	fi

	$(which convert) \
		$1 \
		-bordercolor none \
		-border 10 \
		\( +clone -background \
		black -shadow 110x10+5+5 \) \
		+swap -background none \
		-layers merge +repage \
		$1
}

for i in "$@"
do
	shadow_border_ts "$i"
	if [[ "$?" -eq '0' ]]; then
		echo "$i	[done]"
	fi
done
