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

MIC_NAME="Focusrite_iTrack_Solo-00.iec958-stereo"
VOLUME="100500" #set volume to 110% 

pacmd set-default-source alsa_input.usb-$MIC_NAME #set source to Sennheier
pacmd set-source-volume alsa_input.usb-$MIC_NAME $VOLUME

#always numpad is on: -option numpad:mac
#setxkbmap -layout \"us,ir\" -option \"grp:alt_shift_toggle\" &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
perWindowLayoutD #pre window keyboard layout
