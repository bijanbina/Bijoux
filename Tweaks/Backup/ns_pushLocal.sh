#!/bin/bash
# Name: Net Sync Push to Local servers
# Push backup data from local host to local servers
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_pushLocal.sh

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

if [ "$DIFF_MODE" -eq "0" ]; then # if disable diff mode

	# Copy from local host to local servers
	for i in $(seq 1 $SERVER_COUNT)
	do
		echo "$(date "+%D %R") <local>: Start copy from local host to server${i}" >> "$LOCAL_STORAGE/log_sum"
		echo "$(date "+%D %R") <local>: Start copy from local host to server" >> "$LOCAL_STORAGE/log${i}"
		rsync -rutv --delete "$LOCAL_STORAGE/host/." "$LOCAL_STORAGE/server${i}" >> "$LOCAL_STORAGE/log${i}"
	done

fi