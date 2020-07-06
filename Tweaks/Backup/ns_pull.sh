#!/bin/bash
# Name: Net Sync Pull
# Pull data from servers
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_pull.sh

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

for i in $(seq 1 $SERVER_COUNT)
do
	rsync -rutv --delete /tmp/server${i} "$PATH_LOCAL" >> "$PATH_LOCAL/log${i}"
	echo $(date "+%D %R") ": rsync server${i} completed" >> "$PATH_LOCAL/log"
done