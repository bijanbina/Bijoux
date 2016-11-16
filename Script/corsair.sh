#!/bin/bash
DEV_LIST=($(xinput list | grep ckb1 | awk -F "=" '{print $2}' | awk -F " " '{print $1}'))
for COURSAIR_ID in "${DEV_LIST[@]}"
do
   :
	sudo xinput set-prop $COURSAIR_ID "Evdev Wheel Emulation Inertia" 20
	sudo xinput set-prop $COURSAIR_ID "Evdev Wheel Emulation Timeout" 1
	sudo xinput set-prop $COURSAIR_ID "Evdev Wheel Emulation Button" 9
	sudo xinput set-prop $COURSAIR_ID "Evdev Wheel Emulation" 1
	echo $COURSAIR_ID
done
