#! /bin/bash
# Name: Net Sync Force
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Force to syncronize servers

source ns_variables.sh

function updateSyncTime {
	TIME="$1"
	CURR_TIME=$(date "+%s")
	TIME_TO_RUN=$(( $CURR_TIME + $TIME ))
	echo "$TIME_TO_RUN" > "$PATH_LOCAL/sync_time"
}

ns_init || exit 1

ns_mount || exit 1 # Mount servers

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

echo "Sync completed."

BACKUP_PERIOD_S=$(( 60*60*BACKUP_PERIOD ))
updateSyncTime "$BACKUP_PERIOD_S"