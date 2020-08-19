#! /bin/bash
# Name: Net Sync
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Syncronize n-server files with each other, save conflicts
# and make logs from deleted or modified files.
# This script should be run by activating netSync services 
# from systemctl.

export DIFF_MODE="0"

source ns_variables.sh
source ns_functions.sh

ns_init || exit 1

while :
do

	ns_checkInterval || continue # Wait for sync time to reach 

	ns_mount # Mount servers
	RETRUN_CODE="$?"
	if [ "$RETRUN_CODE" -ne 0 ]; then
		echo $(date "+%D %R") ": Failed to mount Server${RETRUN_CODE}" >> "$PATH_LOCAL/log_error"

		# Show graphical widget for failed mount servers
		OPT=$(zenity --entry --title "Net Sync Backup" --text "Failed to mount server${RETRUN_CODE}\n1. Retry\n2. Retry after 3 hours\n3. Remind me next day")

		if [ "$OPT" -eq "1" ]; then
			continue
		elif [ "$OPT" -eq "2" ]; then
			updateSyncTime 10800 # 3 Hour
			continue
		elif [ "$OPT" -eq "3" ]; then
			# Write second of next day 00:00:00 to sync_time
			date --date="next day" +"%s" > "$PATH_LOCAL/sync_time"
			continue
		else
			notify-send -i "/usr/share/netSync/icon.png" "Net Sync Backup" "Be polite!!!"
			updateSyncTime "$MOUNT_SLEEP"
			continue
		fi
	fi

	echo " ------------------- " >> "$PATH_LOCAL/log"
	echo " ------------------- " >> "$PATH_LOCAL/log1"
	echo " ------------------- " >> "$PATH_LOCAL/log2"

	ns_pull || exit 1 # Pull data from servers

	ns_cleaner || exit 1 # Clean servers (Remove space, Delete spurious files)

	ns_check || exit 1 # Check file names includes spaces or special character
	
	ns_conflict || exit 1

	ns_local || exit 1 # Sync local servers and host for deleted files
	
	ns_push || exit 1 # Push backup data from local to servers

	ns_umount || exit 1 # Unmount servers

	# Remove temp files
	cd "$TEMP_FOLDER"
	if [ $(ls | wc -l) -ne 0 ]; then
		rm *
	fi

	echo $(date "+%D %R") ": Finish script" >> "$PATH_LOCAL/log"

	BACKUP_PERIOD_S=$(( 60*60*BACKUP_PERIOD ))
	ns_updateSyncTime "$BACKUP_PERIOD_S"
done
