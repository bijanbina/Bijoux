#!/bin/bash
# Name: Net Sync Conflict
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_conflict.sh <service-run>
# Variable <service-run> set to 1 if call this script in service mode (default value is 0).

# Save cuurent directory to be resotred upon exit
CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

if [ "$#" -eq "1" ]; then
	SERVICE_ENABLE="$1"
else
	SERVICE_ENABLE="0"
fi

# Directory name for conflicts files.
cd "$PATH_LOCAL/conflicts"
DATE=$(date "+%m%d%y")
DIR_NAME="${DATE}_1"
if [ -d "$DIR_NAME" ]; then
	CNT=$(ls | grep "${DATE}_" | awk -F '_' '{print $NF}' | sort -nr | head -n1)
	CNT=$(($CNT + 1))
	DIR_NAME="${DATE}_${CNT}"
fi
DIR_NAME="${PATH_LOCAL}/conflicts/${DIR_NAME}"
mkdir -p "$DIR_NAME"

# Find files in host and servers
cd "$PATH_LOCAL/host"
find . -type f > "$TEMP_FOLDER/host_files"
for i in $(seq 1 $SERVER_COUNT)
do
	cd "$PATH_LOCAL/server${i}"
	find . -type f > "$TEMP_FOLDER/server${i}_files"
done

# Create files name for make reference file
FILENAME="host_files"
for i in $(seq 1 $SERVER_COUNT)
do
	FILENAME="$FILENAME server${i}_files"
done

# Create reference list for handle conflict files in servers and host
cd "$TEMP_FOLDER"
sort $FILENAME | uniq > reference_file

python3 /usr/bin/ns_conflict.py "$PATH_LOCAL" "$SERVER_COUNT" "$TEMP_FOLDER/reference_file" "$DIR_NAME" "$DIFF_MODE" "$SERVICE_ENABLE"
if [ "$?" -eq 1 ]; then
	echo "Error 103: Check log_error for details"
	exit 1
fi

# Remove conflict direcotry if empty
CHECK_DIR=$(ls -A "$DIR_NAME")
if [ ! "$CHECK_DIR" ]; then
	rmdir "$DIR_NAME"
fi

cd "$CURR_DIR"
