#!/bin/bash

if [[ "$1" == "8" ]]; then

	awesome-client 'awful = require("awful"); awful.tag.viewnext(screen[1])'
	awesome-client 'awful = require("awful"); awful.tag.viewnext(screen[2])'

elif [[ "$1" == "9" ]]; then

	awesome-client 'awful = require("awful"); awful.tag.viewprev(screen[1])'
	awesome-client 'awful = require("awful"); awful.tag.viewprev(screen[2])'

elif [[ "$1" == "qt_find" ]]; then

	xdotool key --delay 200 Ctrl+Shift+f

fi
