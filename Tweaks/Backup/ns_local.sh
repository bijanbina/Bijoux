#!/bin/bash
# Name: Net Sync Local 
# Delete files
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_local.sh <service-run>
# Variable <service-run> set to 1 if call this script in service mode (default value is 0).

source ./ns_functions.sh

CURR_DIR=$(pwd)


if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

if [ "$#" -eq "1" ]; then
	SERVICE_ENABLE="$1"
else
	SERVICE_ENABLE="0"
fi

ns_createList # create host_list and servers_list

# Get directory name based on date for deleted files.
DELETE_DIR="$(ns_dirName "${LOCAL_STORAGE}/delete")"
mkdir -p "$DELETE_DIR"

# create list of deleted files
if [ -f "$TEMP_FOLDER/diff_list" ]; then
	rm "$TEMP_FOLDER/diff_list"
fi

for i in $(seq 1 $SERVER_COUNT)
do
	diff "$TEMP_FOLDER/server${i}_list" "$TEMP_FOLDER/host_list" | grep '^>' | sed 's/^>\ //' >> "$TEMP_FOLDER/diff_list"
done

sort "$TEMP_FOLDER/diff_list" | uniq > "$TEMP_FOLDER/diff_list_uniq"


# Sync local servers and host for deleted files
echo "$(date "+%D %R") <local>: Sync local servers and host" >> "$LOCAL_STORAGE/log_sum"
while read p
do

	DELETED_PATH_FILE=$(dirname "$p")
	if [ "$DIFF_MODE" -eq "0" ];then 

		if [ -e "$LOCAL_STORAGE/host/$p" ]; then
			mkdir -p "${DELETE_DIR}/host/$DELETED_PATH_FILE"
			cp -rup "$LOCAL_STORAGE/host/$p" "${DELETE_DIR}/host/$DELETED_PATH_FILE"
			rm -dr "$LOCAL_STORAGE/host/$p"
		fi

	fi

	for j in $(seq 1 $SERVER_COUNT)
	do

		if [ -e "$LOCAL_STORAGE/server${j}/$p" ]; then
			if [ "$DIFF_MODE" -eq "0" ];then 
				mkdir -p "${DELETE_DIR}/server${j}/$DELETED_PATH_FILE"
				cp -rup "$LOCAL_STORAGE/server${j}/$p" "${DELETE_DIR}/server${j}/$DELETED_PATH_FILE"
				rm -dr "$LOCAL_STORAGE/server${j}/$p"
			fi
		else
			if [ "$SERVICE_ENABLE" -ne "1" ];then 
				echo "delete: server${j} ---> $p"
				# uncomment to show delete files in single line
				# printf "delete: server${j} ---> $p                                                 \r"
			else
				echo "$(date "+%D %R"): delete $p detected from server${j}" >> "$LOG_DIR/log_delete"
			fi
		fi

	done

done <"$TEMP_FOLDER/diff_list_uniq"	


# Remove delete direcotry if empty
CHECK_DIR=$(ls -A "$DELETE_DIR")
if [ ! "$CHECK_DIR" ]; then
	rmdir "$DELETE_DIR"
fi

if [ "$DIFF_MODE" -eq "0" ]; then # if disable diff mode

	# Update host
	for i in $(seq 1 $SERVER_COUNT)
	do
		echo "$(date "+%D %R") <local>: Start copy from local server${i} to host" >> "$LOCAL_STORAGE/log_sum"
		echo "$(date "+%D %R") <local>: Start copy from local server${i} to host" >> "$LOCAL_STORAGE/log${i}"
		cp -rupv "$LOCAL_STORAGE/server${i}/." "$LOCAL_STORAGE/host/" >> "$LOCAL_STORAGE/log${i}"
	done

	# Copy from local host to local servers
	for i in $(seq 1 $SERVER_COUNT)
	do
		echo "$(date "+%D %R") <local>: Start copy from local host to server${i}" >> "$LOCAL_STORAGE/log_sum"
		echo "$(date "+%D %R") <local>: Start copy from local host to server" >> "$LOCAL_STORAGE/log${i}"
		rsync -rutv --delete "$LOCAL_STORAGE/host/." "$LOCAL_STORAGE/server${i}" >> "$LOCAL_STORAGE/log${i}"
	done

fi


cd "$CURR_DIR"