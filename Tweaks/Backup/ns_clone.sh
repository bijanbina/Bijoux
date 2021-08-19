#!/bin/bash
# Name: Net Sync Update 
# Push backup data from local(host) to servers
# To initialize a server for first time create C:\Home\SVN
# Creating SVN folder is mandatory because it is required
# for checking successful server mount.
# Copyright 2020 Faraz Corporation (Author: Sajad Dadashi)
# LGPL v2.0
# Usage: ns_clone.sh <server-id>

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
	sudo mount -t cifs -o $SERVER_LOGIN //$SERVER_IP/home "/tmp/server${i}"
fi

if [ ! -d "/tmp/server${i}/SVN" ]; then
	echo "Mount server${i} failed!!!"
	exit 1
fi

echo $(date "+%D %R") "<update>: Start copy from local host to server${i}"
sudo rsync -rutv --delete-excluded "$LOCAL_STORAGE/host/." "/tmp/server${i}"