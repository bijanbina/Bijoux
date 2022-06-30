#!/bin/bash

APPLICATION="$1"

IS_PC=$(hostname | grep "Bijan-PC")
if [[ "$IS_PC" ]]; then
	KALDI_CAT="sennheiser-dedachi"
	TELEGRAM_PATH="/home/bijan/Temp/Telegram/Telegram"
else
	KALDI_CAT="scarlet"
	TELEGRAM_PATH="/home/bijan/Downloads/Telegram/Telegram"
fi

if [[ "$APPLICATION" == "qt" ]]; then

	TAG="2"
	BATOOL="qtcreator ~/Project/Benjamin/Tools/BaTool.pro"
	REBOND="qtcreator ~/Project/RAIIS/Rebound/Rebound.pro"

	awesome-client "awful = require('bijoux'); set_tag($TAG)"

	awesome-client "spawn_tag('$BATOOL', screen[1].tags[$TAG])"
	sleep 2
	awesome-client "spawn_tag('$REBOND', screen[2].tags[$TAG])"

elif [[ "$APPLICATION" == "kaldi" ]]; then

	xdotool mousemove 960 500
	TAG="2"
	APP1="termite -d ~/Project/Benjamin/Nato"
	APP2="nautilus ~/Project/Benjamin/Nato"

	awesome-client "awful = require('bijoux'); set_tag($TAG)"

	if [[ "$IS_PC" ]]; then
		awesome-client "spawn_tag('$APP2', screen[2].tags[$TAG])"
	fi
	sleep 1

	if [[ "$IS_PC" ]]; then
		echo -n "~/Project/Benjamin/Nato/audio/train/scarlet" | xclip -i -sel clip
		xdotool key --delay 120 ctrl+t ctrl+l ctrl+v Return
		sleep 2
	fi
	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"

	sleep 1
	xdotool type "./record.sh $KALDI_CAT 50"
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

elif [[ "$APPLICATION" == "benjamin" ]]; then


	if [[ "$IS_PC" ]]; then
		xdotool mousemove 2960 500
	else
		xdotool mousemove 1060 500
	fi
	TAG="1"
	APP="termite -d ~/.config/awesome/scripts -e ./benjamin.sh"

	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"

	if [[ "$IS_PC" ]]; then
		awesome-client "spawn_tag('$APP', screen[2].tags[$TAG])"
	else
		awesome-client "spawn_tag('$APP', screen[1].tags[$TAG])"
	fi
	sleep 2
	xdotool click 1
	sleep 0.3
	xdotool key --delay 120 ctrl+shift+equal
	sleep 0.3
	xdotool key --delay 120 ctrl+shift+equal

elif [[ "$APPLICATION" == "bijoux" ]]; then

	TAG="2"
	APP1="gitkraken"
	APP2="nautilus ~/.config/awesome"

	awesome-client "awful = require('bijoux'); set_tag($TAG)"

	if [[ "$IS_PC" ]]; then
		awesome-client "spawn_tag('$APP2', screen[2].tags[$TAG])"
	else
		awesome-client "spawn_tag('$APP2', screen[1].tags[$TAG])"
	fi
	sleep 1
	echo -n "~/Project/Bijoux/Awesome/awesome" | xclip -i -sel clip
	xdotool key --delay 120 ctrl+t ctrl+l ctrl+v Return
	sleep 2
	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "telegram" ]]; then

	TAG="4"
	APP="$TELEGRAM_PATH"

	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"
	awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"

	if [[ "$IS_PC" ]]; then
		awesome-client "spawn_tag('$APP', screen[2].tags[$TAG])"
	else
		awesome-client "spawn_tag('$APP', screen[1].tags[$TAG])"
	fi

elif [[ "$APPLICATION" == "spotify" ]]; then

	TAG="5"
	APP="spotify"

	awesome-client "awful = require('bijoux'); set_tag($TAG)"
	awesome-client "spawn_tag('$APP', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "esi-linux" ]]; then

	TAG="2"
	APP1="/usr/NX/bin/nxplayer --session /home/bijan/Documents/NoMachine/Ehsan-Linux.nxs"

	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "esi-windows" ]]; then

	TAG="2"
	APP1="/usr/NX/bin/nxplayer --session /home/bijan/Documents/NoMachine/Ehsan-Windows.nxs"

	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "mmm" ]]; then

	TAG="2"
	APP1="/usr/NX/bin/nxplayer --session /home/bijan/Documents/NoMachine/M-pc.nxs"

	awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"

elif [[ "$APPLICATION" == "meld" ]]; then

	TAG="5"
	APP1="meld ~/Project/Bijoux/Awesome/awesome/ ~/.config/awesome/"
	APP2="meld ~/Project/Bijoux/Awesome/polybar/ ~/.config/polybar/"

	awesome-client "awful = require('bijoux'); set_tag($TAG)"

	awesome-client "spawn_tag('$APP1', screen[1].tags[$TAG])"
	if [[ "$IS_PC" ]]; then
		awesome-client "spawn_tag('$APP2', screen[2].tags[$TAG])"
	else
		awesome-client "spawn_tag('$APP2', screen[1].tags[$TAG])"
	fi
	sleep 1
	meld "$HOME/Project/Bijoux/Awesome/Code - OSS/User/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
	meld "$HOME/Project/Bijoux/Awesome/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/settings.json"

fi
