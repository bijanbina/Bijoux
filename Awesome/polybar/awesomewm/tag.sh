#!/bin/bash

TAG=$(awesome-client "return screen[$1].selected_tag.name" | cut -d\" -f2)

BG_COLOR="#44ffffff"
FG_COLOR="#f3c84a"
P_FORMAT="%{B$BG_COLOR}%{F$FG_COLOR}"
P_CMD="~/.config/polybar/awesomewm/switch.sh"

TAG_1="%{A1:$P_CMD 1:}    %{A}"
TAG_2="%{A1:$P_CMD 2:}  %{A}"
TAG_3="%{A1:$P_CMD 3:}  %{A}"
TAG_4="%{A1:$P_CMD 4:}    %{A}"
TAG_5="%{A1:$P_CMD 5:}    %{A}"
TAG_6="%{A1:$P_CMD 6:}    %{A}"

#echo $TAG

if [[ "$TAG" == "1" ]]; then

	echo "$P_FORMAT $TAG_1 %{B- F-} $TAG_2 $TAG_3 $TAG_4 $TAG_5 $TAG_6"

elif [[ "$TAG" == "2" ]]; then

	echo "$TAG_1 $P_FORMAT $TAG_2 %{B- F-} $TAG_3 $TAG_4 $TAG_5 $TAG_6"

elif [[ "$TAG" == "3" ]]; then

	echo "$TAG_1 $TAG_2 $P_FORMAT $TAG_3 %{B- F-} $TAG_4 $TAG_5 $TAG_6"

elif [[ "$TAG" == "4" ]]; then

	echo "$TAG_1 $TAG_2 $TAG_3 $P_FORMAT $TAG_4 %{B- F-} $TAG_5 $TAG_6"

elif [[ "$TAG" == "5" ]]; then

	echo "$TAG_1 $TAG_2 $TAG_3 $TAG_4 $P_FORMAT $TAG_5 %{B- F-} $TAG_6"

elif [[ "$TAG" == "6" ]]; then

	echo "$TAG_1 $TAG_2 $TAG_3 $TAG_4 $TAG_5 $P_FORMAT $TAG_6 %{B- F-}"

fi
