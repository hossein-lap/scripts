#!/bin/bash
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

dmenu="dmenu -i -b -l 30"
term="st"
links="$(printf '%s' '' | $dmenu -p 'Put the link (ctrl-shift-y)')"
dl="~/dl"

if [[ -n ${links} ]]; then
	dl_man="$(printf '%s\n' 'wget' 'aria2c' 'yt-dlp' 'help' \
		| $dmenu -p 'Download with:')"
fi

dl_wget () {
	$term wget -c -P $dl ${links}
}

dl_aria2 () {
	$term aria2c -c -x 16 -d $dl ${links}
}

dl_ytdl () {
	$term yt-dlp -o $dl ${links}
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
