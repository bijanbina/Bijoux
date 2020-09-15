#!/bin/bash
# Name: Net Sync Check Filename
# Check whether files contains space or special character.
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_check.sh <service-run>
# Variable <service-run> set to 1 if call this script in service mode (default value is 0).

CURR_DIR=$(pwd)

if [ "$#" -eq "1" ]; then
	SERVICE="$1"
else
	SERVICE="0"
fi

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi


for i in $(seq 1 $SERVER_COUNT)
do

	cd "$LOCAL_STORAGE/server${i}"

	# Check special character in file name
	CHECK_SPECIAL=$( find . | grep '[^a-zA-Z0-9\[\]+/._-]' )
	if [ ! -z "$CHECK_SPECIAL" ]; then
		if [ "$SERVICE" -eq "1" ]; then
			echo $(date "+%D %R") "<check>: Server${i} contain special character in file names" >> "$LOCAL_STORAGE/log_sum"
			echo $(date "+%D %R") "         Check $LOG_DIR/log${i} for more information" >> "$LOCAL_STORAGE/log_sum"
			echo $(date "+%D %R") "\n$CHECK_SPECIAL" >> "$LOG_DIR/log${i}"
		else
			echo "$CHECK_SPECIAL"
		fi
		exit 1
	fi

done

cd "$CURR_DIR"
