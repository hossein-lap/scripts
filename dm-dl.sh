#!/bin/bash
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

bg='#00ff77'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 30"
term="xterm -e"
links="$(printf '%s' ''| $dmenu -p 'Put the link (ctrl-shift-y)')"

if [[ -n ${links} ]]; then
	dl_man="$(printf '%s\n' 'wget' 'aria2c' 'yt-dlp' 'help' \
		| $dmenu -p 'Download with:')"
fi

dl_wget () {
	$term "wget -c -P ~/Downloads ${links}"
}

dl_aria2 () {
	$term "aria2c -c -x 16 -d ~/Downloads ${links}"
}

dl_ytdl () {
	$term "yt-dlp -o ~/Downloads ${links}"
}

help () {
	printf '%s\n' 'dm-dl.sh' \
		'Download links via "wget", "aria2" and "yt-dlp"' \
		'' 'Options:' '    wget' '    aria2c' '    yt-dlp' \
		| $dmenu -l 10 -p 'Help:' > /dev/null
}

case $dl_man in
	wget) dl_wget ;;
	aria2c) dl_aria2 ;;
	yt-dlp) dl_ytdl ;;
	help) help ;;
esac
