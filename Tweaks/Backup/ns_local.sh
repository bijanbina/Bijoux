#!/bin/bash
# Name: Net Sync Local 
# Delete files
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_local.sh

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

ns_list || exit 1 # Fill host_list, servers_list files

# Sync local servers and host for deleted files
echo $(date "+%D %R") ": Sync local servers and host" >> "$PATH_LOCAL/log"
echo
while read p
do

	for i in $(seq 1 $SERVER_COUNT)
	do
		cd "$TEMP_FOLDER"
		CHECK_FILE=$(grep -w "$p" server${i}_list)

		if [ -z "$CHECK_FILE" ]; then

			CHECK_FILE=$(echo "$p" | grep "\[")
			if [ ! -z "$CHECK_FILE" ]; then
				echo $(date "+%D %R") ": error in file name $p " >> "$PATH_LOCAL/log_error"
				echo "error in file name $p"
				break
			fi

			echo $(date "+%D %R") ":(server${i}) $p " >> "$PATH_LOCAL/log_delete"
			printf "delete: server${i} ---> $p                                                 \r"
			
			cp -rup "$PATH_LOCAL/host/$p" "$PATH_LOCAL/delete"
			rm -dr "$PATH_LOCAL/host/$p"

			for j in $(seq 1 $SERVER_COUNT)
			do

				if [ "$i" -ne "$j" ]; then
					cd "$PATH_LOCAL/server${j}"
					# if [ -f ]
					cp -rup "$PATH_LOCAL/server${j}/$p" "$PATH_LOCAL/delete"
					rm -dr "$PATH_LOCAL/server${j}/$p" #FIXME: check file exist
				fi

			done

			break
		fi

	done

done <"$TEMP_FOLDER/host_list"

echo

# Update host
for i in $(seq 1 $SERVER_COUNT)
do
	echo $(date "+%D %R") ": Start copy from local server${i} to host" >> "$PATH_LOCAL/log"
	cp -rupv "$PATH_LOCAL/server${i}/." "$PATH_LOCAL/host/" >> "$PATH_LOCAL/log${i}"
done

cd "$CURR_DIR"