#! /bin/bash
# Name: Net Sync Force
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Force to syncronize servers

export DIFF_MODE="0"

source ns_variables.sh
source ns_functions.sh

ns_version # echo last modified date

echo "ns_init start"
. ns_init || exit 1

echo "ns_mount start"
ns_mount || exit 1 # Mount servers

echo "ns_pull start"
ns_pull || exit 1 # Pull data from servers

echo "ns_live start"
ns_live || exit 1 # Check servers are alive

echo "ns_cleaner start"
ns_cleaner || exit 1 # Clean servers (Remove space, Delete spurious files)

echo "ns_check start"
ns_check || exit 1 # Check file names includes spaces or special character

echo "ns_versionControl start"
ns_versionControl || exit 1 # Backup from version control files in LOCAL_STORAGE/vc_list

echo "ns_conflict start"
ns_conflict || exit 1

echo "ns_local start"
ns_local || exit 1 # Sync local servers and host for deleted files

echo "ns_footprint start"
ns_footprints || exit 1 # Copy footprint and pad to template folder

echo "ns_live start"
ns_live || exit 1 # Check servers are alive

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
