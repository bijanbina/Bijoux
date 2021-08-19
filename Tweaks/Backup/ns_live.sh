#!/bin/bash
# Name: Net Sync Live
# Check servers are alive
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_live.sh

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

for i in $(seq 1 $SERVER_COUNT)
do

	SERVER_IP="IP_SERVER${i}"
	SERVER_IP="${!SERVER_IP}"
	ping -c 1 "$SERVER_IP" >> /dev/null
	rc="$?"
	if [[ "$rc" -ne "0" ]]; then # if ping failed
		echo "ping server${i} failed."

		while true; do
			printf "Try to mount server${i}?[Y/n]: "
			read TRY_MOUNT

			if [ "$TRY_MOUNT" == "n" ]; then
				exit "$i"
			else
				sudo umount -f "/tmp/server${i}"
				SERVER_LOGIN="SERVER${i}_USER"
				SERVER_LOGIN="${!SERVER_LOGIN}"
				SERVER_IP="IP_SERVER${i}"
				SERVER_IP="${!SERVER_IP}"

				sudo mount -t cifs -o $SERVER_LOGIN //$SERVER_IP/home "/tmp/server${i}"
				if [ -d "/tmp/server${i}/SVN" ]; then
					break
				fi
			fi
		done
	fi

done