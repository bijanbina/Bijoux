#!/bin/bash
# Name: Net Sync Push 
# Push backup data from local to servers
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_push.sh

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

# Copy from local host to servers
for i in $(seq 1 $SERVER_COUNT)
do
	echo $(date "+%D %R") "<push>: Start copy from local host to server${i}" >> "$PATH_LOCAL/log"
	sudo rsync -rutv --delete-excluded "$PATH_LOCAL/host/." "/tmp/server${i}" >> "$PATH_LOCAL/log${i}"
done

cd "$CURR_DIR"