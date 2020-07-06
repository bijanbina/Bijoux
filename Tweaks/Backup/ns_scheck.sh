#!/bin/bash

# Name: Net Sync Space Check
# Check whether files contains space.
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_scheck.sh


if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

# Check space in file name
echo $(date "+%D %R") ": Start check space in file names" >> "$PATH_LOCAL/log"

while read p; 
do
	CHECK_PRE=$(echo "$p" | grep ' ')
	if [ -n "$CHECK_PRE" ]; then
		echo "Error: this file name has a space $p"
		exit 1
	fi
done <"$PATH_LOCAL/host_list"

while read p; 
do
	CHECK_PRE=$(echo "$p" | grep ' ')
	if [ -n "$CHECK_PRE" ]; then
		echo "Error: this file name has a space $p"
		exit 1
	fi
done <"$PATH_LOCAL/server1_list"

while read p; 
do
	CHECK_PRE=$(echo "$p" | grep ' ')
	if [ -n "$CHECK_PRE" ]; then
		echo "Error: this file name has a space $p"
		exit 1
	fi
done <"$PATH_LOCAL/server2_list"

echo $(date "+%D %R") ": Finish check space in file names" >> "$PATH_LOCAL/log"