#!/bin/bash

DBUS_DEST=$(qdbus --session | grep org.mpris)
DBUS_DEST="${DBUS_DEST:1}"

if [[ "$#" == "0" ]]; then

	DBUS_NAME="/org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get"
	DBUS_ARGS="string:org.mpris.MediaPlayer2.Player string:PlaybackStatus"

	STATUS=$(dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_ARGS 2>/dev/null)

    if [[ "$?" == "1" ]]; then
        exit
    fi
    
	STATUS=$(echo $STATUS | tail -n 1 | cut -d\" -f2)
	if [[ "$STATUS" == "Playing" ]]; then
	
		echo ""
	
	else
	
		echo ""
	
	fi

elif [[ "$1" == "play" ]]; then

	DBUS_NAME="/org/mpris/MediaPlayer2"
	DBUS_FUNC="org.mpris.MediaPlayer2.Player.PlayPause"
	dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_FUNC

elif [[ "$1" == "next" ]]; then

	DBUS_NAME="/org/mpris/MediaPlayer2"
	DBUS_FUNC="org.mpris.MediaPlayer2.Player.Next"
	dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_FUNC

elif [[ "$1" == "prev" ]]; then

	DBUS_NAME="/org/mpris/MediaPlayer2"
	DBUS_FUNC="org.mpris.MediaPlayer2.Player.Previous"
	dbus-send --print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_FUNC

fi
