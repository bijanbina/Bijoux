#!/bin/bash

TAG=$(awesome-client "return screen[$1].selected_tag.name" | cut -d\" -f2)

TAG_1="    "
TAG_2="  "
TAG_3="    "
TAG_4="    "
TAG_5="    "

BG_COLOR="#44ffffff"
FG_COLOR="#f3c84a"
P_FORMAT="%{B$BG_COLOR}%{F$FG_COLOR}"
P_CMD="~/.config/polybar/awesomewm/switch.sh"

#echo $TAG

if [[ "$TAG" == "1" ]]; then

	echo "%{A1:$P_CMD 1:} $P_FORMAT $TAG_1 %{B- F-} %{A} $TAG_2 $TAG_3 $TAG_4 $TAG_5"

elif [[ "$TAG" == "2" ]]; then

	echo "$TAG_1 $P_FORMAT $TAG_2 %{B- F-} $TAG_3 $TAG_4 $TAG_5"

elif [[ "$TAG" == "3" ]]; then

	echo "$TAG_1 $TAG_2 $P_FORMAT $TAG_3 %{B- F-} $TAG_4 $TAG_5"

elif [[ "$TAG" == "4" ]]; then

	echo "$TAG_1 $TAG_2 $TAG_3 $P_FORMAT $TAG_4 %{B- F-} $TAG_5"

elif [[ "$TAG" == "5" ]]; then

	echo "$TAG_1 $TAG_2 $TAG_3 $TAG_4 $P_FORMAT $TAG_5 %{B- F-}"

fi
