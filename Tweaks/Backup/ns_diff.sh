#!/bin/bash
# Name: Net Sync Difference
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Pull from servers and 
# print files that have special character in filename and
# print conflict files and
# print delete files
# Usage: ns_diff.sh

export DIFF_MODE="1"

source ns_functions.sh
source ns_variables.sh

CURR_DIR=$(pwd)

echo "ns_init start"
ns_init || exit 1

echo "ns_mount start"
ns_mount || exit 1 # Mount servers

echo "ns_pull start"
ns_pull || exit 1 # Pull data from servers

echo "ns_cleaner start"
ns_cleaner || exit 1 # Clean servers (Remove space, Delete spurious files)

echo "ns_check start"
ns_check || exit 1 # Check file names includes spaces or special character

echo "ns_conflict start"
ns_conflict || exit 1

echo "ns_local start"
ns_local || exit 1 # Sync local servers and host for deleted files

echo "ns_umount start"
ns_umount || exit 1 # Unmount servers

# Remove temp files
cd "$TEMP_FOLDER"
if [ $(ls | wc -l) -ne 0 ]; then
	rm *
fi

cd "$CURR_DIR"