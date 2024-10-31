#!/bin/bash
#  ____     _ 
# |  _ \   | |
# | |_) |  | |
# |  __/ |_| |
# |_|   \___/ 
#             

ResX="1920"
ResY="1080"
Res="${ResX}x${ResY}"

# xrandr="$(xrandr | grep connect | grep -v dis | cut -d' ' -f1)"
#
# PRIMARY="echo ${xrandr} | grep DP"
# SECONDARY="echo ${xrandr} | grep SECONDARY"
#
# echo $xrandr $PRIMARY $SECONDARY
# exit 23

PRIMARY="HDMI-2"
SECONDARY="DP-2"

#if [ ${ResX} -gt 1920 ] || [ ${ResX} -gt 1080 ]; then

## old setup of dual-mon
#			--primary --mode ${Res} --pos 0x${ResY} --rotate normal \
#		--output SECONDARY-1 \
#			--mode ${Res} --pos 0x0 --rotate normal \
#			--auto --mode ${Res} --left-of eDP-1 --rotate normal \

if [ "${1}" = '2' ]; then
	xrandr \
		-r 75 \
		--output ${PRIMARY} \
			--primary --auto --mode ${Res} --rotate normal \
		--output ${SECONDARY} \
		-r 75 \
            --auto --mode ${Res} --left-of ${PRIMARY} --rotate normal \
#		--output SECONDARY-2 --off \
#		--output DP-1 --off \
#		--output DP-1-0 --off \
#		--output DP-1-1 --off \
#		--output DP-1-2 --off \
#		--output DP-1-3 --off
elif [ "${1}" = '0' ]; then
	xrandr \
		-r 75 \
		--output ${PRIMARY} \
			--auto --same-as ${SECONDARY} --mode ${Res} \
		--output ${SECONDARY} \
			--mode ${Res} \
		--output HDMI2 --off \
		--output DP-1 --off \
		--output DP-1-0 --off \
		--output DP-1-1 --off \
		--output DP-1-2 --off \
		--output DP-1-3 --off
else
	xrandr \
		-r 75 \
		--output ${PRIMARY} \
			--primary --auto --mode ${Res} --pos 0x${ResY} --rotate normal \
		--output ${SECONDARY} --off \
		--output DP-1 --off \
		--output HDMI2 --off \
		--output DP-1-0 --off \
		--output DP-1-1 --off \
		--output DP-1-2 --off \
		--output DP-1-3 --off
fi

notify-send -u low -a xrandr "resolution is set ${Res}"
sleep 1

# xwallpaper --no-randr --zoom ~/.local/share/dwm/background.jpg
xwallpaper --zoom ~/.local/share/dwm/background.jpg
notify-send -u low -a xwallpaper "background is set"
