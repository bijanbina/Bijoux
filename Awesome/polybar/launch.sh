#!/bin/bash

killall -q polybar
#Number of monitor
MON_COUNT=$(xrandr | grep -w "connected" | wc -l)
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do 
	sleep 1
done

for i in $(seq 1 $MON_COUNT); do
	BARNAME="bbar$i"
	polybar $BARNAME &
done

