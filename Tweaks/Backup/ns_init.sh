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

mkdir -p "$PATH_LOCAL" # -p: no error if existing
mkdir -p "$PATH_LOCAL/host"
mkdir -p "$PATH_LOCAL/conflicts"
mkdir -p "$PATH_LOCAL/delete"
mkdir -p "$PATH_LOCAL/comma"
mkdir -p "$TEMP_FOLDER"

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