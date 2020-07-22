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
	echo "$TIME_TO_RUN" > "$PATH_LOCAL/sync_time"
}

# 0: The backup must be run.
# 1: Sleep script because right time has not come.
function ns_checkInterval {
	CURR_TIME=$(date "+%s")
	
	if [ ! -f "$PATH_LOCAL/sync_time" ]; then
		cat "$CURR_TIME" > "$PATH_LOCAL/sync_time"
	fi

	TIME_TO_RUN=$(cat "$PATH_LOCAL/sync_time")
	if [ ! -z "$TIME_TO_RUN" ]; then
		if [ "$TIME_TO_RUN" -gt "$CURR_TIME" ]; then
			sleep "$CHECK_TIMEOUT_S"
			return 1
		fi
	fi

	return 0
}

