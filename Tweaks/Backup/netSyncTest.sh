#! /bin/bash
# Name: Net Sync Debug Test
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Syncronize n-server files with each other, save conflicts
# and make logs from deleted or modified files.
# This script should be run by activating netSync services 
# from systemctl.

CURR_DIR=$(pwd)
./installSync.sh

export IP_HOST=192.168.1.122
export PATH_LOCAL=/mnt/hdd2/Backup
export IP_SERVER1=192.168.1.131
export SERVER1_USER="username=bijan,password=hello"
export IP_SERVER2=192.168.1.132
export SERVER2_USER="username=bijan,password=seed95"
export SERVER_COUNT=2
export TEMP_FOLDER="$PATH_LOCAL/.temp"

export INTERVAL_BACKUP=3 # Hour
SLEEP_TIME=10 # Minute
SLEEP_TIME_S=$(( 60*SLEEP_TIME ))

ns_init || exit 1

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

	# ns_cinterval
	# if [ "$?" -eq 1 ]; then
	# 	echo "Sleep $SLEEP_TIME_S"
	# 	# sleep "$SLEEP_TIME_S"
	# fi

	echo
	echo "1 - ns_mount: Mount servers"
	echo "2 - ns_pull: Pull data from servers"
	echo "3 - ns_cleaner: Remove space and delete spurious files"
	echo "4 - ns_conflict: Resolve conflict between servers"
	echo "5 - ns_local: Sync local servers and host for deleted files"
	echo "6 - ns_push: Push backup data from local to servers"
	echo "7 - ns_umount: Unmount servers"
	echo "8 - ns_clog: Clear logs"
	echo "0 - Exit"
	echo

	printf "Command>> "
	read response_main

	if [ -z "$response_main" ]; then
		exit
	fi

	if [[ "$response_main" == *"1"* ]]; then
		ns_mount

		RETRUN_CODE="$?"
		if [ "$RETRUN_CODE" -ne 0 ]; then
			notify-send -i "/usr/share/netSync/icon.png" "Net Sync Backup" "Failed to mount Server${RETRUN_CODE}"
			continue
		fi

		echo "ns_mount = $RETRUN_CODE" 
	fi

	if [[ "$response_main" == *"2"* ]]; then
		ns_pull || exit 1
		echo "ns_pull = $?"
	fi

	if [[ "$response_main" == *"3"* ]]; then
		ns_cleaner || exit 1
		echo "ns_cleaner = $?"
	fi

	if [[ "$response_main" == *"4"* ]]; then
		ns_conflict || exit 1
		echo "ns_conflict = $?"
	fi

	if [[ "$response_main" == *"5"* ]]; then
		ns_local || exit 1
		echo "ns_local = $?"
	fi

	if [[ "$response_main" == *"6"* ]]; then
		ns_push || exit 1
		echo "ns_push = $?"
	fi

	if [[ "$response_main" == *"7"* ]]; then
		ns_umount || exit 1
		echo "ns_umount = $?"
	fi

	if [[ "$response_main" == *"8"* ]]; then
		ns_clog || exit 1
		echo "ns_clog = $?"
	fi

	if [[ "$response_main" == *"0"* ]]; then
		break
	fi

	# date "+%s" > "$PATH_LOCAL/last_run"

done