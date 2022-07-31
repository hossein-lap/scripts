#!/bin/bash

shadow_border_ts () {
local imc=$(which convert)

if [[ -z "$imc" ]]; then
	printf '%s\n' "Sorry, you need imagemagik package installed :o"
	exit 1
fi

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
	$2
}

transform () {
	if [[ ! -f "$1.bak" ]]; then
		cp -v "$1" "$1.bak"
	fi
	mv -f "$1" "$1.old"
	shadow_border_ts "$1.old" "$1"
}

for i in "$@"
do 
	transform "$i"
done

if [[ ! -d .im-shadow ]]; then
	mkdir -p .im-shadow/
fi

mv -fv *.{bak,old} .im-shadow/
