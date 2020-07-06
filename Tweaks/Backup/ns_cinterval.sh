#!/bin/bash
# Name: Net Sync Check Interval Time
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_cinterval.sh

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

LAST_RUN=$(cat "$PATH_LOCAL/last_run")
TIME_TO_RUN=$(( $LAST_RUN + 60*60*BACKUP_PERIOD ))
CURR_TIME=$(date "+%s")
if [ "$TIME_TO_RUN" -gt "$CURR_TIME" ]; then
	exit 1
fi