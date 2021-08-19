#!/bin/bash
# Name: Net Sync Initial 
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_init.sh

source ./ns_functions.sh

CURR_DIR=$(pwd)

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

mkdir -p "$LOCAL_STORAGE" # -p: no error if existing
mkdir -p "$LOCAL_STORAGE/host"
mkdir -p "$LOCAL_STORAGE/conflicts"
mkdir -p "$LOCAL_STORAGE/delete"
mkdir -p "$LOCAL_STORAGE/comma"
mkdir -p "$LOCAL_STORAGE/backup"
mkdir -p "$TEMP_FOLDER"
mkdir -p "$LOCAL_STORAGE/log"

# Make directory for log based on date
export LOG_DIR="$(ns_dirName "${LOCAL_STORAGE}/log")"
mkdir -p "$LOG_DIR"

# Make directory in tmp for servers
for i in $(seq 1 $SERVER_COUNT)
do
	mkdir -p "/tmp/server${i}"
done

# Remove temp files
cd "$TEMP_FOLDER"
if [ $(ls | wc -l) -ne 0 ]; then
	rm *
fi

cd "$CURR_DIR"