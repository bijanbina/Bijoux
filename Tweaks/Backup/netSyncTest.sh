#! /bin/bash
# Name: Net Sync Debug Test
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Syncronize n-server files with each other, save conflicts
# and make logs from deleted or modified files.
# This script should be run by activating netSync services 
# from systemctl.

export DIFF_MODE="0"
SERVICE_ENABLE="0"

CURR_DIR=$(pwd)

source ./ns_variables.sh
source ./ns_functions.sh
export LOCAL_STORAGE=/mnt/hdd2/SyncLocalTest
export TEMP_FOLDER="$LOCAL_STORAGE/.temp"

# ./ns_init.sh || exit 1
. ./ns_init.sh || exit 1

# echo server count and ip
echo
echo "Server count = $SERVER_COUNT"
for i in $(seq 1 $SERVER_COUNT)
do
	SERVER_IP="IP_SERVER${i}"
	SERVER_IP="${!SERVER_IP}"
	echo "Ip Server${i} = $SERVER_IP"
done

while true; do

	echo
	echo "1 - ns_mount: Mount servers"
	echo "2 - ns_pull: Pull data from servers"
	echo "3 - ns_cleaner: Remove space and delete spurious files"
	echo "4 - ns_check: Check space and special character"
	echo "v - ns_versionControl: Backup for version control files"
	echo "5 - ns_conflict: Resolve conflict between servers"
	echo "6 - ns_local: Sync local servers and host for deleted files"
	echo "7 - ns_umount: Unmount servers"
	echo "8 - ns_clog: Clear logs"
	echo "l - ns_live: Check servers is alive"
	echo "0 - Exit"
	echo


	printf "Command>> "
	read response_main

	if [ -z "$response_main" ]; then
		exit
	fi

	if [[ "$response_main" == *"l"* ]]; then
		./ns_live.sh || exit 1
		echo "ns_live = $?"
	fi

	if [[ "$response_main" == *"1"* ]]; then
		./ns_mount.sh || exit 1
		echo "ns_mount = $?" 
	fi

	if [[ "$response_main" == *"2"* ]]; then
		./ns_pull.sh "$SERVICE_ENABLE" || exit 1
		echo "ns_pull = $?"
	fi

	if [[ "$response_main" == *"3"* ]]; then
		./ns_cleaner.sh || exit 1
		echo "ns_cleaner = $?"
	fi

	if [[ "$response_main" == *"4"* ]]; then
		./ns_check.sh "$SERVICE_ENABLE" || exit 1
		echo "ns_check = $?"
	fi

	if [[ "$response_main" == *"v"* ]]; then
		./ns_versionControl.sh "$SERVICE_ENABLE" || exit 1
		echo "ns_versionControl = $?"
	fi

	if [[ "$response_main" == *"5"* ]]; then
		./ns_conflict.sh "$SERVICE_ENABLE" || exit 1
		echo "ns_conflict = $?"
	fi

	if [[ "$response_main" == *"6"* ]]; then
		./ns_local.sh "$SERVICE_ENABLE" || exit 1
		echo "ns_local = $?"
	fi

	if [[ "$response_main" == *"7"* ]]; then
		./ns_umount.sh || exit 1
		echo "ns_umount = $?"
	fi

	if [[ "$response_main" == *"8"* ]]; then
		./ns_clog.sh || exit 1
		echo "ns_clog = $?"
	fi

	if [[ "$response_main" == *"9"* ]]; then
		./ns_list.sh || exit 1
		echo "ns_list = $?"
	fi


	if [[ "$response_main" == *"0"* ]]; then
		break
	fi

done