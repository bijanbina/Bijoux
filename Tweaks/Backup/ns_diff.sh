#!/bin/bash
# Name: Net Sync Difference
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Pull from servers and 
# print files that have special character in filename and
# print conflict files and
# print delete files
# Usage: ns_diff.sh

source ns_functions.sh
source ns_variables.sh

CURR_DIR=$(pwd)

echo "ns_init start"
ns_init || exit 1

echo "ns_mount start"
ns_mount || exit 1 # Mount servers

echo "ns_pull start"
ns_pull || exit 1 # Pull data from servers

# Check special character in servers.
echo "Check special character in servers start"
for i in $(seq 1 $SERVER_COUNT)
do

	cd "$PATH_LOCAL/server${i}"
	echo "server${i}"
	# Check special character in file name
	CHECK_SPECIAL=$( find . | grep '[^a-zA-Z0-9+/._-]' )
	if [ ! -z "$CHECK_SPECIAL" ]; then
		echo "$CHECK_SPECIAL"
	fi

done

ns_list || exit 1 # Fill host_list, servers_list files

# Check deleted file in servers
echo "Check deleted file in servers start"
while read p
do

	for i in $(seq 1 $SERVER_COUNT)
	do
		cd "$TEMP_FOLDER"
		CHECK_FILE=$(grep -w "$p" server${i}_list)
		if [ -z "$CHECK_FILE" ]; then
			echo "server${i} ---> $p"
		fi
	done

done <"$TEMP_FOLDER/host_list"

# Check conflict file in servers
echo "Check conflict file in servers start"
# Find files in host and servers
cd "$PATH_LOCAL/host"
find . -type f > "$TEMP_FOLDER/host_files"
for i in $(seq 1 $SERVER_COUNT)
do
	cd "$PATH_LOCAL/server${i}"
	find . -type f > "$TEMP_FOLDER/server${i}_files"
done
# Create files name for make reference file
FILENAME="host_files"
for i in $(seq 1 $SERVER_COUNT)
do
	FILENAME="$FILENAME server${i}_files"
done
# Create reference list for handle conflict files in servers and host
cd "$TEMP_FOLDER"
sort $FILENAME | uniq > reference_file
python3 /usr/bin/ns_diff_conflict.py "$PATH_LOCAL" "$SERVER_COUNT" "$TEMP_FOLDER/reference_file"

echo "ns_umount start"
ns_umount || exit 1 # Unmount servers

cd "$CURR_DIR"