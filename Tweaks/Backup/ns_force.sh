#! /bin/bash
# Name: Net Sync Force
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Force to syncronize servers

source ns_variables.sh
source ns_functions.sh

ns_init || exit 1

ns_mount || exit 1 # Mount servers

ns_pull || exit 1 # Pull data from servers

ns_cleaner || exit 1 # Clean servers (Remove space, Delete spurious files)

ns_check || exit 1 # Check file names includes spaces or special character

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
ns_updateSyncTime "$BACKUP_PERIOD_S"