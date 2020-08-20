#!/bin/bash
# Name: Net Sync Local 
# Delete files
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_local.sh <service-run>
# Variable <service-run> set to 1 if call this script in service mode (default value is 0).

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

if [ "$#" -eq "1" ]; then
	SERVICE_ENABLE="$1"
else
	SERVICE_ENABLE="0"
fi

ns_list || exit 1 # Fill host_list, servers_list files

# Directory name for deleted files.
cd "$PATH_LOCAL/delete"
DATE=$(date "+%m%d%y")
DIR_NAME="${DATE}_1"
if [ -d "$DIR_NAME" ]; then
	CNT=$(ls | grep "${DATE}_" | awk -F '_' '{print $NF}' | sort -nr | head -n1)
	CNT=$(($CNT + 1))
	DIR_NAME="${DATE}_${CNT}"
fi
DIR_NAME="${PATH_LOCAL}/delete/${DIR_NAME}"
mkdir -p "$DIR_NAME"

# Sync local servers and host for deleted files
echo $(date "+%D %R") "<local>: Sync local servers and host" >> "$PATH_LOCAL/log"
while read p
do

	for i in $(seq 1 $SERVER_COUNT)
	do
		cd "$TEMP_FOLDER"
		CHECK_FILE=$(grep -w "$p" server${i}_list)

		if [ -z "$CHECK_FILE" ]; then

			if [ "$SERVICE_ENABLE" -ne "1" ];then 
				echo "delete: server${i} ---> $p"
			fi

			if [ "$DIFF_MODE" -eq "0" ];then 

				echo $(date "+%D %R") ":(server${i}) $p " >> "$PATH_LOCAL/log_delete"
				# printf "delete: server${i} ---> $p                                                 \r"

				DELETED_PATH_FILE=$(dirname "$p")
				mkdir -p "${DIR_NAME}/host/$DELETED_PATH_FILE"
				cp -rup "$PATH_LOCAL/host/$p" "${DIR_NAME}/host/$DELETED_PATH_FILE"
				rm -dr "$PATH_LOCAL/host/$p"

				for j in $(seq 1 $SERVER_COUNT)
				do

					if [ "$i" -ne "$j" ]; then
						if [ -e "$PATH_LOCAL/server${j}/$p" ]; then
							mkdir -p "${DIR_NAME}/server${j}/$DELETED_PATH_FILE"
							cp -rup "$PATH_LOCAL/server${j}/$p" "${DIR_NAME}/server${j}/$DELETED_PATH_FILE"
							rm -dr "$PATH_LOCAL/server${j}/$p"
						fi
					fi

				done
			fi

			break
		fi

	done

done <"$TEMP_FOLDER/host_list"

# Remove delete direcotry if empty
CHECK_DIR=$(ls -A "$DIR_NAME")
if [ ! "$CHECK_DIR" ]; then
	rmdir "$DIR_NAME"
fi

if [ "$DIFF_MODE" -eq "0" ]; then # if disable diff mode

	# Update host
	for i in $(seq 1 $SERVER_COUNT)
	do
		echo $(date "+%D %R") "<local>: Start copy from local server${i} to host" >> "$PATH_LOCAL/log"
		cp -rupv "$PATH_LOCAL/server${i}/." "$PATH_LOCAL/host/" >> "$PATH_LOCAL/log${i}"
	done

	# Copy from local host to local servers
	for i in $(seq 1 $SERVER_COUNT)
	do
		echo $(date "+%D %R") "<local>: Start copy from local host to server${i}" >> "$PATH_LOCAL/log"
		rsync -rutv --delete-excluded "$PATH_LOCAL/host/." "$PATH_LOCAL/server${i}" >> "$PATH_LOCAL/log${i}"
	done

fi


cd "$CURR_DIR"