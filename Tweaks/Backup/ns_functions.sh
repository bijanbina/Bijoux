#! /bin/bash
# Name: Net Sync Utility Functions
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0

# Check file or directory exist
# 0: not exist
# 1: exist
function ns_checkExist {
	DIR="$1"
	if [ -f "$DIR" ]; then
		return 1
	fi

	if [ -d "$DIR" ]; then
		return 1
	fi

	return 0
}

function ns_updateSyncTime {
	TIME="$1"
	CURR_TIME=$(date "+%s")
	TIME_TO_RUN=$(( $CURR_TIME + $TIME ))
	echo "$TIME_TO_RUN" > "$LOCAL_STORAGE/sync_time"
}

# 0: The backup must be run.
# 1: Sleep script because right time has not come.
function ns_checkInterval {
	CURR_TIME=$(date "+%s")
	
	if [ ! -f "$LOCAL_STORAGE/sync_time" ]; then
		cat "$CURR_TIME" > "$LOCAL_STORAGE/sync_time"
	fi

	TIME_TO_RUN=$(cat "$LOCAL_STORAGE/sync_time")
	if [ ! -z "$TIME_TO_RUN" ]; then
		if [ "$TIME_TO_RUN" -gt "$CURR_TIME" ]; then
			sleep "$CHECK_TIMEOUT_S"
			return 1
		fi
	fi

	return 0
}

function ns_version {
	MODIFY_DATE_MAX=0
	FILE_LAST_EDIT=""
	while read line; do
		MODIFY_DATE="$(ns_modify $line)"
		if [ "$MODIFY_DATE" -gt "$MODIFY_DATE_MAX" ]; then
			MODIFY_DATE_MAX="$MODIFY_DATE"
			FILE_LAST_EDIT="$line"
		fi
	done < "/usr/share/netSync/file_list"
	echo "NetSync, Last build date=$(date "+%m-%d-%Y %H:%M:%S" -d @${MODIFY_DATE_MAX})"
}

function ns_modify {
	FILE="$1"
	MODIFY_DATE="$(date -r $FILE "+%s")"
	echo "$MODIFY_DATE"
}

function ns_dirName {
	if [ "$#" -eq "1" ]; then
		DIR="$1"
	else
		return 1
	fi

	L_CURR_DIR=$(pwd) # local current directory

	cd "$DIR"
	DATE=$(date "+%m%d%y")
	DIR_NAME="${DATE}_1"
	if [ -d "$DIR_NAME" ]; then
		CNT=$(ls | grep "${DATE}_" | awk -F '_' '{print $NF}' | sort -nr | head -n1)
		CNT=$(($CNT + 1))
		DIR_NAME="${DATE}_${CNT}"
	fi

	cd "$L_CURR_DIR"

	echo "${DIR}/${DIR_NAME}"
}

# Fill host_list, servers_list files
function ns_createList {

	L_CURR_DIR=$(pwd) # local current directory

	if [ -f "$TEMP_FOLDER/host_list" ]; then
		rm "$TEMP_FOLDER/host_list"
	fi

	CHECK_DIR=$(ls -A "$LOCAL_STORAGE/host")
	# if directory is empty
	if [ ! "$CHECK_DIR" ]; then
		touch "$TEMP_FOLDER/host_list"
	else 
		cd "$LOCAL_STORAGE/host"
		find * | tac > "$TEMP_FOLDER/host_list"
		sort -o "$TEMP_FOLDER/host_list" "$TEMP_FOLDER/host_list"
	fi

	for i in $(seq 1 $SERVER_COUNT)
	do

		if [ -f "$TEMP_FOLDER/server${i}_list" ]; then
			rm "$TEMP_FOLDER/server${i}_list"
		fi

		# if directory is empty
		CHECK_DIR=$(ls -A "$LOCAL_STORAGE/server${i}")
		if [ ! "$CHECK_DIR" ]; then
			touch "$TEMP_FOLDER/server${i}_list"
		else 
			cd "$LOCAL_STORAGE/server${i}"
			find * | tac > "$TEMP_FOLDER/server${i}_list"
			sort -o "$TEMP_FOLDER/server${i}_list" "$TEMP_FOLDER/server${i}_list"
		fi
		
	done

	cd "$L_CURR_DIR"
}
