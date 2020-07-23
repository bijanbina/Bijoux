#!/bin/bash
# Name: Net Sync Update 
# Push backup data from local(host) to servers
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Usage: ns_update.sh <server-id>

./installSync.sh
source ns_variables.sh

i="$1"
if [ -z "$i" ]; then
	echo "Please enter your server id"
	exit 1
fi
echo "selected server id = $i"

SERVER_LOGIN="SERVER${i}_USER"
SERVER_LOGIN="${!SERVER_LOGIN}"
SERVER_IP="IP_SERVER${i}"
SERVER_IP="${!SERVER_IP}"

mkdir -p "/tmp/server${i}"	

if [ ! -d "/tmp/server${i}/SVN" ]; then
	sudo mount -t cifs -o $SERVER_LOGIN //$SERVER_IP/Home "/tmp/server${i}"
fi

if [ ! -d "/tmp/server${i}/SVN" ]; then
	echo "Mount server${i} failed!!!"
	exit 1
fi

echo $(date "+%D %R") "<update>: Start copy from local host to server${i}"
sudo rsync -rutv --delete-excluded "$PATH_LOCAL/host/." "/tmp/server${i}"
