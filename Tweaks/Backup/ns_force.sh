#! /bin/bash
# Name: Net Sync Force
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Force to syncronize servers

source ns_variables.sh
source ns_functions.sh

echo "ns_init start"
ns_init || exit 1

echo "ns_mount start"
ns_mount || exit 1 # Mount servers

echo "ns_pull start"
ns_pull || exit 1 # Pull data from servers

echo "ns_cleaner start"
ns_cleaner || exit 1 # Clean servers (Remove space, Delete spurious files)

echo "ns_check start"
ns_check # Check file names includes spaces or special character
# RESULT="$?"
if [ "$?" -eq "1" ]; then
	CHECK_SPECIAL=$( find . | grep '[^a-zA-Z0-9+/._-]' )
	if [ ! -z "$CHECK_SPECIAL" ]; then
		echo "$CHECK_SPECIAL"
		exit 1
	fi
fi

echo "ns_conflict start"
ns_conflict || exit 1

echo "ns_local start"
ns_local || exit 1 # Sync local servers and host for deleted files

echo "ns_push start"
ns_push || exit 1 # Push backup data from local to servers

echo "ns_umount start"
ns_umount || exit 1 # Unmount servers

# Remove temp files
cd "$TEMP_FOLDER"
if [ $(ls | wc -l) -ne 0 ]; then
	rm *
fi

BACKUP_PERIOD_S=$(( 60*60*BACKUP_PERIOD ))
ns_updateSyncTime "$BACKUP_PERIOD_S"

echo "Sync completed."