#!/bin/bash
# Name: Net Sync Initial 
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_init.sh

source ns_functions.sh

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

# FIXME: check kardan shart lazem nist
if [ ! -d "$PATH_LOCAL" ]; then
	mkdir -p "$PATH_LOCAL" # -p: no error if existing
fi

if [ ! -d "$PATH_LOCAL/host" ]; then
	mkdir -p "$PATH_LOCAL/host"
fi

if [ ! -d "$PATH_LOCAL/conflicts" ]; then
	mkdir -p "$PATH_LOCAL/conflicts"
fi

if [ ! -d "$PATH_LOCAL/delete" ]; then
	mkdir -p "$PATH_LOCAL/delete"
fi

if [ ! -d "$PATH_LOCAL/comma" ]; then
	mkdir -p "$PATH_LOCAL/comma"
fi

# Make directory in tmp for servers
for i in $(seq 1 $SERVER_COUNT)
do

	if [ ! -d "/tmp/server${i}" ]; then
		mkdir -p "/tmp/server${i}"
	fi

done

if [ ! -d "$TEMP_FOLDER" ]; then
	mkdir -p "$TEMP_FOLDER"
fi

# Remove temp files
cd "$TEMP_FOLDER"
if [ $(ls | wc -l) -ne 0 ]; then
	rm *
fi

cd "$CURR_DIR"