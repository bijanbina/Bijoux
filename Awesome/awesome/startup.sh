#!/bin/bash

#disable display sleep
xset s off
xset -dpms
xset s noblank

#always numpad is on: -option numpad:mac
setxkbmap -layout "us,ir" -option "grp:alt_shift_toggle" -option numpad:mac

PC_NAME=$(hostname)
if [[ "$PC_NAME" == "Bijan-UX390" ]]; then

	xrandr --output DP1 --output eDP1 --off
	
	#pactl set-card-profile 0 "output:analog-stereo+input:analog-stereo"
	pactl set-card-profile 0 "output:hdmi-stereo+input:analog-stereo"
	pactl set-card-profile 1 "output:analog-stereo+input:mono-fallback"

	pactl set-default-sink "alsa_output.pci-0000_00_1f.3.hdmi-stereo"

else

	xrandr --output HDMI-3 --output DVI-0 --left-of HDMI-3
	
	MIC_NAME="Focusrite_iTrack_Solo-00.iec958-stereo"
	VOLUME="100500" #set volume to 110% 

	pacmd set-default-source alsa_input.usb-$MIC_NAME #set source to Sennheier
	pacmd set-source-volume alsa_input.usb-$MIC_NAME $VOLUME

	xinput set-prop 10 "Coordinate Transformation Matrix" 0.75 0.000000 0.000000 0.000000 0.75 0.000000 0.000000 0.000000 1.000000
	xset m 1 1

fi

#always numpad is on: -option numpad:mac
setxkbmap -layout "us,ir" -option "grp:alt_shift_toggle" &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
perWindowLayoutD & #pre window keyboard layout
# Clipboard Fix Window Close Bug
parcellite &
#must be called after setxkbmap
xmodmap -e "keycode 135 = Super_L"
