#!/bin/bash
# Name: Net Sync Check Filename
# Check whether files contains space or special character.
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_check.sh

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi


for i in $(seq 1 $SERVER_COUNT)
do

	cd "$PATH_LOCAL/server${i}"

	# Check space in file name
	CHECK_SPACE=$( find . | grep ' ' )
	if [ ! -z "$CHECK_SPACE" ]; then
		echo $(date "+%D %R") "<check>: Server${i} have space in file name" >> "$PATH_LOCAL/log"
		echo "$CHECK_SPACE" >> "$PATH_LOCAL/log"
		echo "Error 101: File name contain space charaters and cannot automatically solved by ns_cleaner"
		exit 1
	fi

	# Check special character in file name
	CHECK_SPECIAL=$( find . | grep '[^a-zA-Z0-9_-\+\/.]' )
	if [ ! -z "$CHECK_SPECIAL" ]; then
		echo $(date "+%D %R") "<check>: Server${i} have special character in file name" >> "$PATH_LOCAL/log"
		echo "$CHECK_SPECIAL" >> "$PATH_LOCAL/log"
		echo "Error 102: File name contain special charaters"
		exit 1
	fi

done

cd "$CURR_DIR"