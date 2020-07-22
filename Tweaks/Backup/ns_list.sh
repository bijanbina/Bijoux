#!/bin/bash
# Name: Net Sync File List
# Make file list in host and servers
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_list.sh

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

if [ -f "$TEMP_FOLDER/host_list" ]; then
	rm "$TEMP_FOLDER/host_list"
fi

cd "$PATH_LOCAL/host"
find * | tac > "$TEMP_FOLDER/host_list"

for i in $(seq 1 $SERVER_COUNT)
do

	if [ -f "$TEMP_FOLDER/server${i}_list" ]; then
		rm "$TEMP_FOLDER/server${i}_list"
	fi

	cd "$PATH_LOCAL/server${i}"
	find * > "$TEMP_FOLDER/server${i}_list"
done