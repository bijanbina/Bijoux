#!/bin/bash
# Name: Net Sync Footprints
# Copy footprint and pad to template folder
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_footprints.sh <service-run>
# Variable <service-run> set to 1 if call this script in service mode (default value is 0).

if [ "$#" -eq "1" ]; then
	SERVICE="$1"
else
	SERVICE="0"
fi

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

while read PROJECT_NAME
do

	python3 ./ns_footprints.py "$LOCAL_STORAGE" "$PROJECT_NAME" "$DIFF_MODE" "$SERVICE"

done < "$LOCAL_STORAGE/project_list"

