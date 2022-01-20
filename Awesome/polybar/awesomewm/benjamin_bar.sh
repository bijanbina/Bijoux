#!/bin/bash

BG_COLOR="#88f50a4d"
FG_COLOR="#f3f8fa"
X_FORMAT="%{B$BG_COLOR}%{F$FG_COLOR}"
S_FORMAT="%{B#8800a7ff}%{F$FG_COLOR}"
SPEX_FILE=~/.config/polybar/awesomewm/ben_spex
STATUS_FILE=~/.config/polybar/awesomewm/ben_status

if [[ -f $SPEX_FILE ]]; then

	STATUS=$(cat $SPEX_FILE)
    echo "${X_FORMAT}  SPEX ${STATUS}  %{B- F-}"
    
elif [[ -f $STATUS_FILE ]]; then

	STATUS=$(cat $STATUS_FILE)
	
	if [[ "$STATUS" ]]; then
    	
    	echo "${S_FORMAT}  ${STATUS}  %{B- F-}"
    	
    fi

else

	echo ""

fi
