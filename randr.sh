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

#if [ ${ResX} -gt 1920 ] || [ ${ResX} -gt 1080 ]; then

## old setup of dual-mon
#			--primary --mode ${Res} --pos 0x${ResY} --rotate normal \
#		--output HDMI-1 \
#			--mode ${Res} --pos 0x0 --rotate normal \
#			--auto --mode ${Res} --right-of eDP-1 --rotate normal \

if [ "${1}" -eq 2 ]; then
	xrandr \
		--output eDP-1 \
			--primary --auto --mode ${Res} --rotate normal \
		--output HDMI-1 \
			--auto --mode ${Res} --above eDP-1 --rotate normal \
#		--output HDMI-2 --off \
#		--output DP-1 --off \
#		--output DP-1-0 --off \
#		--output DP-1-1 --off \
#		--output DP-1-2 --off \
#		--output DP-1-3 --off
elif [ "${1}" -eq 0 ]; then
	xrandr \
		--output eDP-1 \
			--auto --same-as HDMI-1 --mode ${Res} \
		--output HDMI-1 \
			--mode ${Res} \
		--output HDMI-2 --off \
		--output DP-1 --off \
		--output DP-1-0 --off \
		--output DP-1-1 --off \
		--output DP-1-2 --off \
		--output DP-1-3 --off
else
	xrandr \
		--output eDP-1 \
			--primary --auto --mode ${Res} --pos 0x${ResY} --rotate normal \
		--output HDMI-1 --off \
		--output DP-1 --off \
		--output HDMI-2 --off \
		--output DP-1-0 --off \
		--output DP-1-1 --off \
		--output DP-1-2 --off \
		--output DP-1-3 --off
fi

notify-send -u low -a xrandr "resolution is set ${Res}"
sleep 1

xwallpaper --no-randr --zoom ~/pictures/.wall
notify-send -u low -a xwallpaper "background is set"
