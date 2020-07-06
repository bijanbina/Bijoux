#!/bin/bash

export PATH_LOCAL=/mnt/hdd2/Backup

while read p; do
	cd "$PATH_LOCAL/server1"
	da=$(stat --format=%X "$p") #date access
	dm=$(stat --format=%Y "$p") #date modification
	ddm=$(date -r "$p" +%s)
	if [[ ! "$ddm" -eq "$dm" ]]; then
		echo "$p"
		echo "Access time: $da, Modification time: $dm, date: $ddm"
	fi
done <"$PATH_LOCAL/server1_list"