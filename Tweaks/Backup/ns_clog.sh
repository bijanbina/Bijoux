#!/bin/bash
# Name: Net Sync Clear Logs
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# This script should be call from netSync.sh 
# to define required envirovmental variables.
# Usage: ns_clog.sh

CURR_DIR=$(pwd)

if [ -z ${PATH_LOCAL+x} ]; then 
	echo "Please run net sync first to define envirovment variables."
	exit 1
fi

cd "$PATH_LOCAL"
> log
> log1
> log2
> log_conflict
> log_delete
> log_error

cd "$CURR_DIR"