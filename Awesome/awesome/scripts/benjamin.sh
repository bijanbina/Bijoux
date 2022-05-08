#!/bin/bash

timedatectl set-ntp false
DATE=$(timedatectl | grep "Local time" | awk '{print $4}')
TIME=$(timedatectl | grep "Local time" | awk '{print $5}')
YY=$(echo "$DATE"  | cut -d "-" -f1)
MM=$(echo "$DATE"  | cut -d "-" -f2)
DD=$(echo "$DATE"  | cut -d "-" -f3)

# send type

DBUS_PATH="--dest=com.binaee.rebound / com.binaee.rebound"
dbus-send --session $DBUS_PATH.type  string:"101"

./open_graph.sh
read -p "Day: " REQ_DATE

sleep 0.5
xdotool key --delay 100 Super_L+k
sleep 0.1

cd ~/Project/Benjamin

clear

# remove leading zero -> #0
if [[ "$REQ_DATE" -gt "${DD#0}" ]]; then

	MM=$(($MM-1))
	MM=$(printf "%02d" $MM) #Add leading zero if needed
	FULL_DATE="$YY-$MM-$REQ_DATE $TIME"
	tput setaf 3 #orange
	echo "D:$FULL_DATE"
	tput sgr0 #normal
	timedatectl set-time "$FULL_DATE"

else

	FULL_DATE="$YY-$MM-$REQ_DATE $TIME"
	tput setaf 1 #green
	echo "D:$FULL_DATE"
	tput sgr0 #normal
	timedatectl set-time "$FULL_DATE"

fi

git log --oneline -10 --format="%C(Yellow)  %ad %C(reset) %s" --date=short
printf "\n\n\n\n\n\nGit Status:\n"

git status -s
xdotool key --delay 50 Super_L+q
sleep 0.5


ZENITY_OPT='zenity --entry  --width 800 --text='
COMMIT_MSG=$(GDK_DPI_SCALE=2 $ZENITY_OPT"Commit Message" --entry-text="BaTool: ")
clear

if [[ "$COMMIT_MSG" ]]; then

	git commit -m "$COMMIT_MSG"
	echo "This window will die in 5 seconds..."
	sleep 10

else
	
	echo "Commit Canceled"
	echo "This window will die in 3 seconds..."
	sleep 3

fi
timedatectl set-ntp true

TAG="2"
awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"
