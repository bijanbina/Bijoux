#!/bin/bash
# Name: Net Sync Mount servers in /tmp
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_mount.sh

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

for i in $(seq 1 $SERVER_COUNT)
do
	SERVER_LOGIN="SERVER${i}_USER"
	SERVER_LOGIN="${!SERVER_LOGIN}"
	SERVER_IP="IP_SERVER${i}"
	SERVER_IP="${!SERVER_IP}"

	if [ ! -d "/tmp/server${i}/SVN" ]; then
		sudo mount -t cifs -o $SERVER_LOGIN //$SERVER_IP/home "/tmp/server${i}"
	fi

	if [ ! -d "/tmp/server${i}/SVN" ]; then
		echo "Mount server${i} failed!!!"
		exit "$i"
	fi

done