#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

#!/bin/sh

ScrShot() {
local choice=$(printf '%s\n' \
	"whole screen" "active window" "area" "quit" \
		| dmenu -p 'Take screenshot' \
		| awk '{print $1}')

if [ ! -d "$HOME/Pictures/shots" ]; then
	mkdir -p $HOME/Pictures/shots
fi

case ${choice} in
	quit)
		echo "Screenshot cancelled!" && exit 0
	;;
	whole)
		scrot '%y%m%d_%H%M%S_$wx$h.png' \
			-e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f & echo ~/Pictures/shots/$f | xclip -selection clipboard -t text/html; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
			#-e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
		# -e 'feh $f --title "feh - scrot preview" -g 640x480 '
	;;
	active)
		scrot -d 1 -u '%y%m%d_%H%M%S_$wx$h.png' \
			-e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f & echo ~/Pictures/shots/$f | xclip -selection clipboard -t text/html; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
		# -e 'feh $f --title "feh - scrot preview" -g 640x480 '
	;;
	area)
		scrot -d 1 -s '%y%m%d_%H%M%S_$wx$h.png' \
			-e 'mv $f ~/Pictures/shots/; sxiv ~/Pictures/shots/$f & echo ~/Pictures/shots/$f | xclip -selection clipboard -t text/html; xclip -selection clipboard -t image/png -i ~/Pictures/shots/$f'
		# -e 'feh $f --title "feh - scrot preview" -g 640x480 '
	;;
	*)
		echo "Program terminated!" && exit 1
	;;
esac
}

ScrShot
