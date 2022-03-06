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

	xdotool mousemove 960 500
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
	sleep 0.1
	xdotool key super+space
	sleep 0.1
	xdotool keydown super+shift
	sleep 0.1
	xdotool key --delay 120 Right Right Right Right Down Down
	sleep 0.2
	xdotool keyup super+shift
	sleep 0.2
	xdotool keydown super+alt
	sleep 0.1
	xdotool key --delay 120 Right Right
	sleep 0.2
	xdotool keyup super+alt
	sleep 0.2
	xdotool key --delay 120 ctrl+shift+equal
	sleep 0.2
	xdotool key --delay 120 ctrl+shift+equal

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

elif [[ "$APPLICATION" == "telegram" ]]; then

	TAG="4"
	APP1="/home/bijan/Temp/Telegram/Telegram"

	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "spotify" ]]; then

	TAG="5"
	APP1="spotify"

	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "meld" ]]; then

	TAG="5"
	APP1="meld ~/Project/Bijoux/Awesome/awesome/ ~/.config/awesome/"
	APP2="meld ~/Project/Bijoux/Awesome/polybar/ ~/.config/polybar/"
	APP3="meld ~/Project/Bijoux/Awesome/picom/ ~/.config/picom/"

	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"
	awesome-client "spawn_tag('$APP2', screen[2].tags[$TAG])"
	awesome-client "spawn_tag('$APP3', screen[2].tags[$TAG])"

fi
