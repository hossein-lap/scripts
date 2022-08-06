#!/bin/bash
#  _  _ ___
# | || | __|	H
# | __ | _|		A
# |_||_|___|	P
#

bg='#ffaa00'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 30"

# help {{{
help () {
cat << _EOF_
dmenu usb management script

Usage: dm-usb.sh [muel]

no args: interactive menu

m:     mount device
u:     unmount device
e:     eject device
l:     list of devices
h:     help
_EOF_
}
# }}}
# check status {{{
stat_check () {
	if [ -z "${1}" ]; then
		fortune | sed 's/\t/    /g' | $dmenu > /dev/null
		exit 0
	fi
}
# }}}
# list {{{
list () {
	lsblk --fs --ascii | $dmenu -p 'List:' > /dev/null
}
# }}}
# mount {{{
mount () {
	device=$(lsblk -lmnp -o NAME,MOUNTPOINTS -M \
		| grep -E '[0-9]' \
		| grep -v nvme \
		| $dmenu \
			-p "Mount:" )

	stat_check "${device}"

	for i in $(printf '%s\n' ${device} | awk '{print $1};')
	do
		udisksctl mount -b ${i}
	done
}
# }}}
# unmount {{{
unmount () {
	device=$(lsblk -lmnp -o NAME,MOUNTPOINTS -M \
		| grep -E '[0-9]' \
		| grep '^\/' \
		| grep -v nvme \
		| $dmenu \
			-p "Unmount:" )

	stat_check "${device}"

	for i in $(printf '%s\n' ${device} | awk '{print $1};')
	do
		udisksctl unmount -b ${i}
	done
}
# }}}
# eject {{{
pwr_off () {
	device=$(lsblk -lmnp -o NAME \
		| grep -E -v '[0-9]$' \
		| grep '^\/' \
		| grep -v nvme \
		| $dmenu \
			-p "Eject:" )

	stat_check "${device}"

	for i in $(printf '%s\n' ${device} | awk '{print $1};')
	do
		udisksctl power-off -b ${i}
	done
}
# }}}
# interactive {{{
interactive () {
	i=$( printf '%s\n' \
		"List" \
		"Help" \
		"Mount" \
		"Unmount" \
		"Eject" \
		| $dmenu -p 'Interactive menu:')

	stat_check "$i"

	case $i in
		Mount) mount ;;
		Unmount) unmount ;;
		Eject) pwr_off ;;
		List) list ;;
		Help) help | $dmenu -p 'dm-usb.sh:' > /dev/null ;;
		*) exit 1 ;;
	esac
}
# }}}

case $1 in
	m) mount ;;
	u) unmount ;;
	e) pwr_off ;;
	l) list ;;
	h) help | $dmenu -p 'dm-usb.sh:' > /dev/null ;;
	*) interactive ;;
esac
