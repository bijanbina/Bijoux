#!/bin/bash

APPLICATION="$1"

if [[ "$APPLICATION" == "qt" ]]; then

	TAG="4"
	BATOOL="qtcreator ~/Project/Benjamin/Tools/BaTool.pro"
	REBOND="qtcreator ~/Project/RAIIS/Rebound/Rebound.pro"

	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$BATOOL', screen[2].tags[$TAG])"
	sleep 2
	awesome-client "spawn_tag('$REBOND', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "kaldi" ]]; then

	TAG="2"
	APP1="nautilus ~/Project/Benjamin/Nato"
	APP2="termite -d ~/Project/Benjamin/Nato"

	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"
	sleep 1
	echo -n "~/Project/Benjamin/Nato/audio/train/scarlet" | xclip -i -sel clip
	xdotool key --delay 120 ctrl+t ctrl+l ctrl+v Return
	sleep 2
	awesome-client "spawn_tag('$APP2', screen[2].tags[$TAG])"
	sleep 1
	xdotool type "./train.sh scarlet 50"

elif [[ "$APPLICATION" == "bijoux" ]]; then

	TAG="2"
	APP1="nautilus ~/.config/awesome"
	APP2="gitkraken"

	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"
	sleep 1
	echo -n "~/Project/Bijoux/Awesome/awesome" | xclip -i -sel clip
	xdotool key --delay 120 ctrl+t ctrl+l ctrl+v Return
	sleep 2
	awesome-client "spawn_tag('$APP2', screen[2].tags[$TAG])"

fi
