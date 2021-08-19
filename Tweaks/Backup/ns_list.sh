#!/bin/bash
# Name: Net Sync File List
# Make file list in host and servers
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_list.sh

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

if [ -f "$TEMP_FOLDER/host_list" ]; then
	rm "$TEMP_FOLDER/host_list"
fi

CHECK_DIR=$(ls -A "$LOCAL_STORAGE/host")
# if directory is empty
if [ ! "$CHECK_DIR" ]; then
	touch "$TEMP_FOLDER/host_list"
else 
	cd "$LOCAL_STORAGE/host"
	find * | tac > "$TEMP_FOLDER/host_list"
	sort -o "$TEMP_FOLDER/host_list" "$TEMP_FOLDER/host_list"
fi

for i in $(seq 1 $SERVER_COUNT)
do

	if [ -f "$TEMP_FOLDER/server${i}_list" ]; then
		rm "$TEMP_FOLDER/server${i}_list"
	fi

	# if directory is empty
	CHECK_DIR=$(ls -A "$LOCAL_STORAGE/server${i}")
	if [ ! "$CHECK_DIR" ]; then
		touch "$TEMP_FOLDER/server${i}_list"
	else 
		cd "$LOCAL_STORAGE/server${i}"
		find * | tac > "$TEMP_FOLDER/server${i}_list"
		sort -o "$TEMP_FOLDER/server${i}_list" "$TEMP_FOLDER/server${i}_list"
	fi
	
done