#!/bin/bash

if [[ "$#" == "0" ]]; then

	DBUS_DEST="org.mpris.MediaPlayer2.spotify"
	DBUS_NAME="/org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get"
	DBUS_ARGS="string:org.mpris.MediaPlayer2.Player string:PlaybackStatus"

	STATUS=$(dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_ARGS)
	STATUS=$(echo $STATUS | tail -n 1 | cut -d\" -f2)
	if [[ "$STATUS" == "Playing" ]]; then
	
		echo ""
	
	else
	
		echo ""
	
	fi

elif [[ "$1" == "play" ]]; then

	DBUS_DEST="org.mpris.MediaPlayer2.spotify"
	DBUS_NAME="/org/mpris/MediaPlayer2"
	DBUS_FUNC="org.mpris.MediaPlayer2.Player.PlayPause"
	dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_FUNC

elif [[ "$1" == "next" ]]; then

	DBUS_DEST="org.mpris.MediaPlayer2.spotify"
	DBUS_NAME="/org/mpris/MediaPlayer2"
	DBUS_FUNC="org.mpris.MediaPlayer2.Player.Next"
	dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_FUNC

elif [[ "$1" == "prev" ]]; then

	DBUS_DEST="org.mpris.MediaPlayer2.spotify"
	DBUS_NAME="/org/mpris/MediaPlayer2"
	DBUS_FUNC="org.mpris.MediaPlayer2.Player.Previous"
	dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_FUNC

fi
