#!/bin/bash

BG_COLOR="#44ffffff"
FG_COLOR="#f3c84a"
P_FORMAT="%{B$BG_COLOR}%{F$FG_COLOR}"
P_CMD="~/.config/polybar/spotify.sh"
STATUS=$(~/.config/polybar/spotify.sh)

if [[ "$STATUS" == "" ]]; then

	P_CMD="~/.config/polybar/youtube.sh"
	STATUS=$(~/.config/polybar/youtube.sh)

fi

if [[ "$STATUS" == "" ]]; then

    exit 0

fi

TAG_1="%{A1:$P_CMD prev:}    %{A}"
TAG_2="%{A1:$P_CMD play:}  $STATUS  %{A}"
TAG_3="%{A1:$P_CMD next:}    %{A}"

echo "$TAG_1 $TAG_2 $TAG_3"
