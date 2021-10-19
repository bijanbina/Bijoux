#!/bin/sh
#Written By Bijan Binaee <bijan@binaee.com>
#ARCH Tue Nov 22 23:48:15 CET 2015 x86_64 GNU/Linux
BRIGHT="$(xbacklight -get)"
if [ $(echo " $BRIGHT < 3" | bc) -eq 1  ]; then
	if [ $(echo " $BRIGHT > 1" | bc) -eq 1  ]; then
		xbacklight -dec 1
	fi
else
	xbacklight -dec 3
fi
