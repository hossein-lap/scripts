#!/bin/bash
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

bg='#ff77cc'
fg='#070707'
scrot="scrot -d"
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 30"

ScrShot() {
local choice=$(printf '%s\n' \
	"whole screen" "active window" "area" "quit" \
		| $dmenu -p 'Take screenshot:' \
		| awk '{print $1}')

if [ ! -d "$HOME/Pictures/shots" ]; then
	mkdir -p $HOME/Pictures/shots
fi

case ${choice} in
	quit)
		fortune | sed 's/\t/    /g' | $dmenu -c -l 30 > /dev/null
		exit 0
	;;
	whole)
		scrot '%y%m%d_%H%M%S_$wx$h.png' \
			-q 99 -e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f & echo ~/Pictures/shots/$f | xclip -selection clipboard -t text/html; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
			## -q 99 -e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
		## -q 99 -e 'feh $f --title "feh - scrot preview" -g 640x480 '
	;;
	active)
		scrot -u '%y%m%d_%H%M%S_$wx$h.png' \
			-q 99 -e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f & echo ~/Pictures/shots/$f | xclip -selection clipboard -t text/html; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
		## -q 99 -e 'feh $f --title "feh - scrot preview" -g 640x480 '
	;;
	area)
		scrot -s '%y%m%d_%H%M%S_$wx$h.png' \
			-q 99 -e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f & echo ~/Pictures/shots/$f | xclip -selection clipboard -t text/html; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
		## -q 99 -e 'feh $f --title "feh - scrot preview" -g 640x480 '
	;;
	*)
		fortune | sed 's/\t/    /g' | $dmenu -c -l 30 > /dev/null
		exit 0
	;;
esac
}

ScrShot
