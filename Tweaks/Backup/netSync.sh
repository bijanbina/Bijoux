#! /bin/bash
# Name: Net Sync
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Syncronize n-server files with each other, save conflicts
# and make logs from deleted or modified files.
# This script should be run by activating netSync services 
# from systemctl.

source ns_variables.sh

ns_init || exit 1

while :
do

	ns_cinterval # Wait for BACKUP_PERIOD 
	if [ "$?" -eq 1 ]; then
		echo "Sleep $CHECK_TIMEOUT_S (s)"
		sleep "$CHECK_TIMEOUT_S"
		continue
	fi

	ns_mount # Mount servers
	RETRUN_CODE="$?"
	if [ "$RETRUN_CODE" -ne 0 ]; then
		notify-send -i "/usr/share/netSync/icon.png" "Net Sync Backup" "Failed to mount Server${RETRUN_CODE}"
		echo $(date "+%D %R") ": Failed to mount Server${RETRUN_CODE}" >> "$PATH_LOCAL/log_error"
		sleep "$MOUNT_SLEEP"
		continue
	fi

	echo " ------------------- " >> "$PATH_LOCAL/log"
	echo " ------------------- " >> "$PATH_LOCAL/log1"
	echo " ------------------- " >> "$PATH_LOCAL/log2"

	ns_pull || exit 1 # Pull data from servers

	ns_cleaner || exit 1 # Clean servers (Remove space, Delete spurious files)
	
	ns_conflict || exit 1

	ns_local || exit 1 # Sync local servers and host for deleted files
	
	ns_push || exit 1 # Push backup data from local to servers

	# Remove temp files
	cd "$TEMP_FOLDER"
	if [ $(ls | wc -l) -ne 0 ]; then
		rm *
	fi

	echo $(date "+%D %R") ": Finish script" >> "$PATH_LOCAL/log"
	# sleep "$SLEEP_TIME_S"
	exit
done
