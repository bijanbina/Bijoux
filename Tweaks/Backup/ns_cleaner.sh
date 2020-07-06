#!/bin/bash
# Name: Net Sync Cleaner
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Remove Space and Clean Servers from:
# 1. *.lck
# 2. *.jrl
# 3. *.err
# 4. *.log
# 5. *.iml
# 6. *.dml
# 7. signoise.run directory
# 8. sigxp.run directory
# Usage: ns_cleaner.sh

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

FILE_NAMES="$TEMP_FOLDER/file_names"
FILE_RM_DIR="$TEMP_FOLDER/rm_dir"

for i in $(seq 1 $SERVER_COUNT)
do

	if [ -f $FILE_NAMES ]; then
		rm "$FILE_NAMES"
	fi

	# Remove Space in file names
	cd "$PATH_LOCAL/server${i}"
	find . | tac | grep ' ' > "$FILE_NAMES"
	while read p; do
		FILE_NAME=$(echo "$p" | awk -F "/" '{print $NF}')
		CHECK=$(echo "$FILE_NAME" | grep ' ')
		if [ -n "$CHECK" ]; then
			FILE_NAME_NS=$(echo "$FILE_NAME" | tr ' ' '_')
			DIR_FILE=$(dirname "$p")
			NEW_FILE_NAME="${DIR_FILE}/${FILE_NAME_NS}"
			echo "--server${i}-- $p -> $NEW_FILE_NAME"
			mv "$p" "$NEW_FILE_NAME"
		fi
	done <"$FILE_NAMES"

	if [ -f $FILE_RM_DIR ]; then
		rm "$FILE_RM_DIR"
	fi

	# Delete All spurious file in server
	echo $(date "+%D %R") ": Delete extra files in server${i}" >> "$PATH_LOCAL/log"
	cd "$PATH_LOCAL/server${i}"
	sudo find . \( -name "*.lck*" -o -name "*.jrl*" -o -name "*.err*" -o -name "*.log*" -o -name "*.dml*" -o -name "*.iml*" \) -type f -delete

	find . -name "signoise.run" -type d > "$FILE_RM_DIR"
	echo $(date "+%D %R") ": Delete signoise.run folder in server${i}" >> "$PATH_LOCAL/log"
	while read p; 
	do
		sudo rm -rd "$p"
	done <"$FILE_RM_DIR"

	find . -name "sigxp.run" -type d > "$FILE_RM_DIR"
	echo $(date "+%D %R") ": Delete sigxp.run folder in server${i}" >> "$PATH_LOCAL/log"
	while read p; 
	do
		sudo rm -rd "$p"
	done <"$FILE_RM_DIR"

done

if [ -f $FILE_NAMES ]; then
	rm "$FILE_NAMES"
fi

if [ -f $FILE_RM_DIR ]; then
	rm "$FILE_RM_DIR"
fi

cd "$CURR_DIR"