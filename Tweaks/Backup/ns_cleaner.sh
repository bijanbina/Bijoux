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
# 9. Files in their name have '~$' format
# 10. Files in their name have ',' format
# Usage: ns_cleaner.sh
source ns_functions.sh

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

FILE_NAMES="$TEMP_FOLDER/file_names"
FILE_RM_DIR="$TEMP_FOLDER/rm_dir"
COMMA_FILES="$TEMP_FOLDER/comma_files"

for i in $(seq 1 $SERVER_COUNT)
do

	# Remove temp files that excel create
	cd "$PATH_LOCAL/server${i}"
	find . -name '*~\$*' -type f -delete

	# Remove Space in file names
	if [ -f $FILE_NAMES ]; then
		rm "$FILE_NAMES"
	fi

	cd "$PATH_LOCAL/server${i}"
	find . | tac | grep ' ' > "$FILE_NAMES"
	while read p; do
		FILE_NAME=$(echo "$p" | awk -F "/" '{print $NF}')
		CHECK=$(echo "$FILE_NAME" | grep ' ')

		if [ ! -z "$CHECK" ]; then
			FILE_NAME_NS=$(echo "$FILE_NAME" | tr ' ' '_')
			DIR_FILE=$(dirname "$p")
			NEW_FILE_NAME="${DIR_FILE}/${FILE_NAME_NS}"
			ns_checkExist "$PATH_LOCAL/server${i}/$NEW_FILE_NAME"
			if [ "$?" -eq 0 ]; then
				echo $(date "+%D %R") "<cleaner>: Replace space with underscore (server${i}), $p -> $NEW_FILE_NAME" >> "$PATH_LOCAL/log"
				mv "$p" "$NEW_FILE_NAME"
			else
				echo $(date "+%D %R") "<cleaner>: Remove (server${i}), $p" >> "$PATH_LOCAL/log"
				rm -dr "$p"
			fi
		fi

	done <"$FILE_NAMES"

	# Delete All spurious file in server
	if [ -f $FILE_RM_DIR ]; then
		rm "$FILE_RM_DIR"
	fi

	echo $(date "+%D %R") "<cleaner>: Delete extra files in server${i}" >> "$PATH_LOCAL/log"
	cd "$PATH_LOCAL/server${i}"
	find . \( -name "*.lck*" -o -name "*.jrl*" -o -name "*.err*" -o -name "*.log*" -o -name "*.dml*" -o -name "*.iml*" \) -type f -delete

	find . -name "signoise.run" -type d > "$FILE_RM_DIR"
	echo $(date "+%D %R") "<cleaner>: Delete signoise.run folder in server${i}" >> "$PATH_LOCAL/log"
	while read p; 
	do
		rm -rd "$p"
	done <"$FILE_RM_DIR"

	find . -name "sigxp.run" -type d > "$FILE_RM_DIR"
	echo $(date "+%D %R") "<cleaner>: Delete sigxp.run folder in server${i}" >> "$PATH_LOCAL/log"
	while read p; 
	do
		rm -rd "$p"
	done <"$FILE_RM_DIR"

	if [ -f $COMMA_FILES ]; then
		rm "$COMMA_FILES"
	fi

	# Remove comma files
	cd "$PATH_LOCAL/server${i}"
	find . -name "*,*" > "$COMMA_FILES"
	while read p;
	do
		echo $(date "+%D %R") "<cleaner>: Delete in server${i} [$p]" >> "$PATH_LOCAL/log"
		cp -rup "$PATH_LOCAL/server${i}/$p" "$PATH_LOCAL/comma"
		rm -dr "$PATH_LOCAL/server${i}/$p"
	done <"$COMMA_FILES"


done

if [ -f $FILE_NAMES ]; then
	rm "$FILE_NAMES"
fi

if [ -f $FILE_RM_DIR ]; then
	rm "$FILE_RM_DIR"
fi

if [ -f $COMMA_FILES ]; then
	rm "$COMMA_FILES"
fi

cd "$CURR_DIR"