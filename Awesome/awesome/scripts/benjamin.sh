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
xdotool key --delay 50 Super_L+k
read -p "Day: " REQ_DATE
xdotool key --delay 50 Super_L+k

cd ~/Project/Benjamin

reset

if [[ "$REQ_DATE" -gt "$DD" ]]; then

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
sleep 0.2
xdotool key --delay 50 Super_L+q


ZENITY_OPT='zenity --entry  --width 800 --text='
COMMIT_MSG=$(GDK_DPI_SCALE=2 $ZENITY_OPT"Commit Message" --entry-text="BaTool: ")

timedatectl set-ntp true