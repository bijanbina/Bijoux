#! /bin/sh

if [ ! -d /tmp/system1 ]; then
	mkdir /tmp/system1
fi

if [ ! -d /tmp/system2 ]; then
	mkdir /tmp/system2
fi


while :
do
	/home/bijan/Projects/Bijoux/Tweaks/Backup/backup_raw.sh
	wait
done

#sync recursive with verbose output
