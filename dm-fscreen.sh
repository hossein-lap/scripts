#!/bin/sh
#  _  _
# | || |
# | __ |
# |_||_|
#
set -e

bg='#00ff77'
fg='#070707'
dmenu="dmenu -sb $bg -sf $fg -nf $bg -nb $fg -c -l 30"

# Kill {{{
stop_record () {
	pid=$(pgrep ffmpeg)
	thesig=$(printf '%s\n' \
		"2   SIGINT   Interrupt  Terminate" \
		"3   SIGQUIT  Quit       Terminate with core dump" \
		"9   SIGKILL  Kill       Forced termination" \
		"15  SIGTERM  Terminate  Terminate" \
		| $dmenu -p 'Send signal:' \
		| awk '{print $1;}')
	
	if [ -z "${thesig}" ]; then
		kill="kill -s 15"
	else
		kill="kill -s $thesig"
	fi

	if [ -z "${pid}" ]; then
		fortune | sed 's/\t/    /g' | $dmenu
	else
		$kill "${pid}"
	fi
}
# }}}
# selecte window {{{
record_sel_window () {
	if [ ! -d ~/Videos/record ]; then
		mkdir -p ~/Videos/record
	fi

	local DemRes=($(xdotool selectwindow getwindowgeometry --shell | awk -F '=' '{print $NF;}'))
	local OutRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')
	local PaDev=$(pactl list short sources | awk '{print $2;}' | grep output)
	local Name=$(date +%Y-%m-%d_%H-%M-%S)

	xwininfo | {
	while IFS=: read -r k v; do
		case "$k" in
		*"Absolute upper-left X"*) x=$v;;
		*"Absolute upper-left Y"*) y=$v;;
		*"Border width"*) bw=$v ;;
		*"Width"*) w=$v;;
		*"Height"*) h=$v;;
		esac
	done

	ffmpeg -y -f x11grab -framerate 30 \
			-video_size "$((w))x$((h))" \
			-i "+$((x+bw)),$((y+bw))" \
			-f pulse -ac 2 \
			-i "${PaDev}" \
			-vcodec libx264 \
			-acodec flac \
			-loglevel quiet -stats \
			~/Videos/record/"${BaseName}"-"${Name}".mkv
	}
}
# }}}
# active window {{{
record_act_window () {
	if [ ! -d ~/Videos/record ]; then
		mkdir -p ~/Videos/record
	fi

	local DemRes=($(xwininfo -id $(xdotool getactivewindow)))
	local OutRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')
	local PaDev=$(pactl list short sources | awk '{print $2;}' | grep output)
	local Name=$(date +%Y-%m-%d_%H-%M-%S)

	xwininfo -id $(xdotool getactivewindow) | {
	while IFS=: read -r k v; do
		case "$k" in
		*"Absolute upper-left X"*) x=$v;;
		*"Absolute upper-left Y"*) y=$v;;
		*"Border width"*) bw=$v ;;
		*"Width"*) w=$v;;
		*"Height"*) h=$v;;
		esac
	done

	ffmpeg -y -f x11grab -framerate 30 \
			-video_size "$((w))x$((h))" \
			-i "+$((x+bw)),$((y+bw))" \
			-f pulse -ac 2 \
			-i "${PaDev}" \
			-vcodec libx264 \
			-acodec flac \
			-loglevel quiet -stats \
			~/Videos/record/"${BaseName}"-"${Name}".mkv
	}
}
# }}}
# whole screen {{{
record_screen () {
	if [ ! -d ~/Videos/record ]; then
		mkdir -p ~/Videos/record
	fi

	local DemRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')
	local PaDev=$(pactl list short sources | awk '{print $2;}' | grep output)
	local Name=$(date +%Y-%m-%d_%H-%M-%S)

	ffmpeg \
		-f x11grab \
		-s "${DemRes}" \
		-i :0.0 \
		-f pulse -ac 2 \
		-i "${PaDev}" \
		-vcodec libx264 \
		-acodec flac \
		-r 30 \
        -loglevel quiet -stats \
		~/Videos/record/"${BaseName}"-"${Name}".mkv
}
# }}}
# Help {{{
help () {
	printf '%s\n' "$0" "Record screen/window" \
		"   using ffmpeg" \
	| $dmenu -p 'Help'
}
# }}}

# main {{{
choice=$(printf '%s\n' \
	"Whole screen" \
	"Active window" \
	"Select window" \
	"Help" \
	"Stop" \
	| $dmenu -p 'ffmpeg screen recorder' | awk '{print $1;}')

case $choice in
	Select|Whole|Active)
		BaseName=$(printf '%s' "" \
			| $dmenu -p 'Output name:')

		if [ -z "${BaseName}" ]; then
			BaseName="screen_record"
		fi
	;;
esac

case $choice in
	Select) record_sel_window
	;;
	Active) record_act_window
	;;
	Whole) record_screen
	;;
	Stop) stop_record
	;;
	Help) help
	;;
	*) fortune | sed 's/\t/    /g' | $dmenu
	;;
esac
# }}}
