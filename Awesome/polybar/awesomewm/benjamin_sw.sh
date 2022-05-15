#!/bin/bash

STATUS_FILE=~/.config/polybar/awesomewm/ben_status

if [[ -f $STATUS_FILE ]]; then

	STATUS=$(cat $STATUS_FILE)
	
	if [[ "$STATUS" == "Halt" ]]; then

		rm $STATUS_FILE
		# send go wake
		DBUS_PATH="--dest=com.binaee.rebound / com.binaee.rebound"
		dbus-send --session $DBUS_PATH.meta string:"6" # go
		dbus-send --session $DBUS_PATH.nato string:"17" # wake

	else

    	echo "Halt" > $STATUS_FILE
    	
    fi

fi