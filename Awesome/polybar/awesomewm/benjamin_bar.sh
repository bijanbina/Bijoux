#!/bin/bash

BG_COLOR="#88f50a4d"
FG_COLOR="#f3f8fa"
HB_COLOR="#666666" #Halt background color
HF_COLOR="#ffffff" #Halt foreground color
X_FORMAT="%{B$BG_COLOR}%{F$FG_COLOR}"
S_FORMAT="%{B#8800a7ff}%{F$FG_COLOR}"
H_FORMAT="%{B$HB_COLOR}%{F$HF_COLOR}"
SPEX_FILE=~/.config/polybar/awesomewm/ben_spex
STATUS_FILE=~/.config/polybar/awesomewm/ben_status

HS_CMD="~/.config/polybar/awesomewm/benjamin_sw.sh"

TAG_1="%{A1:$HS_CMD 1:}    %{A}"
if [[ -f $SPEX_FILE ]]; then

	STATUS=$(cat $SPEX_FILE)
    echo "${X_FORMAT}  SPEX ${STATUS}  %{B- F-}"
    
elif [[ -f $STATUS_FILE ]]; then

	STATUS=$(cat $STATUS_FILE)
	
	if [[ "$STATUS" == "Halt" ]]; then

    	echo "${H_FORMAT}%{A1:$HS_CMD:}  ${STATUS}  %{A}%{B- F-} "

	else

    	echo "${S_FORMAT}%{A1:$HS_CMD:}  ${STATUS}  %{A}%{B- F-} "
    	
    fi

else

	echo ""

fi
