#!/bin/bash

IS_ON=$(ifconfig | grep tun0 | wc -l)

BG_COLOR="#44ffffff"
FG_COLOR="#f3c84a"
P_FORMAT="%{B$BG_COLOR}%{F$FG_COLOR}"
P_CMD="~/.config/polybar/awesomewm/vpn_switch.sh"

TAG_1="%{A1:$P_CMD 1:}    %{A}"
TAG_2="%{A1:$P_CMD 2:}  %{A}"

#echo $TAG

if [[ "$IS_ON" == "1" ]]; then

	echo "$P_FORMAT $TAG_1 %{B- F-}"

elif [[ "$IS_ON" == "0" ]]; then

	echo " $TAG_2 "

fi
