#!/bin/bash

if [[ "$1" == "8" ]]; then

	awesome-client 'awful = require("awful"); awful.tag.viewnext(screen[1])'
	awesome-client 'awful = require("awful"); awful.tag.viewnext(screen[2])'

elif [[ "$1" == "9" ]]; then

	awesome-client 'awful = require("awful"); awful.tag.viewprev(screen[1])'
	awesome-client 'awful = require("awful"); awful.tag.viewprev(screen[2])'

elif [[ "$1" == "change_mx" ]]; then

	if [[ -e /tmp/mx_mon ]]; then
	
		STATE=$(cat /tmp/mx_mon)
		
		if [[ "$STATE" == "1" ]]; then
		
			xdotool key --delay 200 Ctrl+Alt+2
			echo 2 > /tmp/mx_mon
			
		else
		
			xdotool key --delay 200 Ctrl+Alt+1
			echo 1 > /tmp/mx_mon
		
		fi
	
	else
	
		echo 1 > /tmp/mx_mon
		xdotool key --delay 200 Ctrl+Alt+1
	
	fi

fi
