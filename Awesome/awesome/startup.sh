#!/bin/bash

#disable display sleep
xset s off
xset -dpms
xset s noblank

MSI=$(xrandr | grep "600mm x 340mm") #MSI
if [[ "$MSI" ]]; then

	xrandr --output DP1 --output eDP1 --off
	
	#pactl set-card-profile 0 "output:analog-stereo+input:analog-stereo"
	pactl set-card-profile 0 "output:hdmi-stereo+input:analog-stereo"
	pactl set-card-profile 1 "output:analog-stereo+input:mono-fallback"

	pactl set-default-sink "alsa_output.pci-0000_00_1f.3.hdmi-stereo"
	

fi

#always numpad is on: -option numpad:mac
#setxkbmap -layout \"us,ir\" -option \"grp:alt_shift_toggle\" &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
