#! /bin/sh

ip_host=192.168.1.122
ip_system1=192.168.1.121
ip_system2=192.168.1.120

if [ ! -d /tmp/system1 ]; then
	mkdir /tmp/system1
fi

if [ ! -d /tmp/system2 ]; then
	mkdir /tmp/system2
fi


while :
do
	xterm -e ./backup_raw.sh
	wait
done

#sync recursive with verbose output
