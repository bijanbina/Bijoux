#!/bin/bash

if [[ "$1" == "8" ]]; then

	awesome-client 'awful = require("awful"); awful.tag.viewnext(screen[1])'
	awesome-client 'awful = require("awful"); awful.tag.viewnext(screen[2])'

elif [[ "$1" == "9" ]]; then

	awesome-client 'awful = require("awful"); awful.tag.viewprev(screen[1])'
	awesome-client 'awful = require("awful"); awful.tag.viewprev(screen[2])'

elif [[ "$1" == "qt_find" ]]; then

	xdotool key --delay 200 Ctrl+Shift+f

elif [[ "$1" == "qt_continue" ]]; then

	xdotool key --delay 200 Ctrl+Shift+F5

elif [[ "$1" == "qt_restart" ]]; then

	xdotool key --delay 200 Ctrl+Shift+F6

elif [[ "$1" == "qt_refractor" ]]; then

	sleep 0.3
	xdotool key --delay 200 Menu
	sleep 0.3
	xdotool key Down Down Down Down Down Down Down Down Down
	sleep 0.1
	xdotool key Right Down
	# xdotool key --delay 200 Return

fi
