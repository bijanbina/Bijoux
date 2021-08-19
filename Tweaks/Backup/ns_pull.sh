#!/bin/bash
# Name: Net Sync Pull
# Pull data from servers
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_pull.sh

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

for i in $(seq 1 $SERVER_COUNT)
do
	echo "pull from server${i} start"
	rsync -rutv --delete "/tmp/server${i}" "$LOCAL_STORAGE" >> "$LOG_DIR/log${i}"
	echo $(date "+%D %R") "<pull>: rsync server${i} completed" >> "$LOCAL_STORAGE/log_sum"
done