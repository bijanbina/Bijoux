#!/bin/sh
#Written By Bijan Binaee <bijan@binaee.com>
#ARCH Tue Nov 22 23:48:15 CET 2015 x86_64 GNU/Linux
echo hi | systemd-cat
MOUNT_DIRECTORY=/srv/ftp
for device in $( ls /dev | sed -n -e '/sd[a-z][1-9]/p' ); do
	if [ ! -d /$MOUNT_DIRECTORY/$device ]; then
		mkdir $MOUNT_DIRECTORY/$device
		echo $MOUNT_DIRECTORY/$device/ not exist | systemd-cat
	fi
	/sbin/mount /dev/$device $MOUNT_DIRECTORY/$device/ #executed if device is not mounted
	#ls -l /dev/$device
done
echo done | systemd-cat
