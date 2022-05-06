#!/bin/bash

if [[ "$1" == "change" ]]; then

	if [[ -e /tmp/mx_mon ]]; then
	
		STATE=$(cat /tmp/mx_mon)
		
		if [[ "$STATE" == "1" ]]; then
		
			xdotool keydown Ctrl+Alt
			echo 2 > /tmp/mx_mon
			echo 2 > ~/Project/Benjamin/Tools/Resources/bar_result
			sleep 0.1
			xdotool key 2
			xdotool keyup Ctrl+Alt
			
		else
		
			xdotool keydown Ctrl+Alt
			echo 1 > /tmp/mx_mon
			echo 1 > ~/Project/Benjamin/Tools/Resources/bar_result
			sleep 0.1
			xdotool key 1
			xdotool keyup Ctrl+Alt
		
		fi
	
	else
	
		echo 1 > /tmp/mx_mon
		xdotool key --delay 200 Ctrl+Alt+1
	
	fi

elif [[ "$1" == "right" ]]; then

	xdotool keydown Ctrl+Alt
	echo 1 > /tmp/mx_mon
	echo 1 > ~/Project/Benjamin/Tools/Resources/bar_result
	sleep 0.1
	xdotool key 2
	xdotool keyup Ctrl+Alt

elif [[ "$1" == "down" ]]; then

	xdotool keydown Ctrl+Alt
	echo 2 > /tmp/mx_mon
	echo 2 > ~/Project/Benjamin/Tools/Resources/bar_result
	sleep 0.1
	xdotool key 1
	xdotool keyup Ctrl+Alt

fi
