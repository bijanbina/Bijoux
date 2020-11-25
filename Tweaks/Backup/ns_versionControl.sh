#!/bin/bash
# Name: Net Sync Version Control
# Modified files in LOCAL_STORAGE/vc_list
# copy to backup folder
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_versionControl.sh <service-run>
# Variable <service-run> set to 1 if call this script in service mode (default value is 0).

if [ -z ${LOCAL_STORAGE+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

if [ "$#" -eq "1" ]; then
	SERVICE_ENABLE="$1"
else
	SERVICE_ENABLE="0"
fi

CURR_DIR=$(pwd)

if [ ! -e "${LOCAL_STORAGE}/vc_list" ]; then

	if [ "$SERVICE_ENABLE" -eq "1" ]; then
		echo "$(date "+%D %R") <versionControl>: vc_list does not exist in $LOCAL_STORAGE" >> "${LOCAL_STORAGE}/log_sum"
	else
		echo "vc_list does not exist in $LOCAL_STORAGE"
	fi

	exit 0

fi

while read vc_file
do

	BASE_FILE_NAME=$(basename -- "$vc_file")
	VC_FILE_NAME=${BASE_FILE_NAME%%.*}
	VC_EXTENSION=${BASE_FILE_NAME#*.}

	HOST_FILE="${LOCAL_STORAGE}/host/SVN/${vc_file}"
	DIR_FILE=$(dirname "$vc_file")

	if [ -e "$HOST_FILE" ]; then

		HOST_MOD_TIME=$(date +%s -r "${LOCAL_STORAGE}/host/SVN/${vc_file}")

		for i in $(seq 1 $SERVER_COUNT)
		do

			SERVER_FILE="${LOCAL_STORAGE}/server${i}/SVN/${vc_file}"

			if [ -e "$SERVER_FILE" ]; then

				SERVER_MOD_TIME=$(date +%s -r "$SERVER_FILE")

				if [ "$SERVER_MOD_TIME" -gt "$HOST_MOD_TIME" ]; then

					DIR_DES="${LOCAL_STORAGE}/backup/${DIR_FILE}"
					CURRENT_DATE=$(date +'%y%m%d')
					FILE_NAME_DES="${VC_FILE_NAME}_${CURRENT_DATE}_server${i}.${VC_EXTENSION}"

					# if file exists update file name destination
					if [ -e "${DIR_DES}/${FILE_NAME_DES}" ]; then

						L_CURR_DIR=$(pwd) # local current directory
						cd "${DIR_DES}"
						CNT=$(ls | grep "${VC_FILE_NAME}_${CURRENT_DATE}_server${i}" | awk -F '_' '{print $NF}' | awk -F '.' '{print $1}' | sort -nr | head -n1)
						CNT=$(($CNT + 1))
						FILE_NAME_DES="${VC_FILE_NAME}_${CURRENT_DATE}_server${i}_${CNT}.${VC_EXTENSION}"
						cd "$L_CURR_DIR"

					fi

					if [ "$DIFF_MODE" -eq "0" ]; then
						mkdir -p "$DIR_DES"
						cp -rupv "$SERVER_FILE" "${DIR_DES}/${FILE_NAME_DES}" >> "${LOCAL_STORAGE}/log_vc"
					elif [ "$SERVICE_ENABLE" -ne "1" ]; then 
						echo "backup: server${i} ---> $vc_file"
					fi

				fi

			fi

		done

	fi

done <"${LOCAL_STORAGE}/vc_list"	
