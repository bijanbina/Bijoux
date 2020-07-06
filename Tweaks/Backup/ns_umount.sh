#!/bin/bash
# Name: Net Sync Unmount servers from /tmp
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_umount.sh

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

for i in $(seq 1 $SERVER_COUNT)
do

	if [ -d "/tmp/server${i}/SVN" ]; then
		echo $(date "+%D %R") ": Start unmount server${i}" >> "$PATH_LOCAL/log"
		sudo umount "/tmp/server${i}"
	fi

done