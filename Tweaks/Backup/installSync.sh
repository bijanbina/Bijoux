#!/bin/sh

#sudo mkdir -m 777 /usr/share/netsync/
sudo cp ./netSync.service /usr/lib/systemd/system/

printf "Enable Net Sync services?[y/N]: "
read response
if [ "$response" = "y" ]; then
	sudo systemctl enable netSync.service
	sudo systemctl start netSync.service
fi

if [ ! -d "/usr/share/netSync" ]; then
	mkdir -p "/usr/share/netSync"
fi

sudo cp ./icon.png /usr/share/netSync/icon.png

sudo cp ./ns_variables.sh /usr/bin/ns_variables
sudo cp ./netSync.sh /usr/bin/netSync
sudo cp ./ns_init.sh /usr/bin/ns_init
sudo cp ./ns_cinterval.sh /usr/bin/ns_cinterval
sudo cp ./ns_conflict.sh /usr/bin/ns_conflict
sudo cp ./ns_cleaner.sh /usr/bin/ns_cleaner
sudo cp ./ns_mount.sh /usr/bin/ns_mount
sudo cp ./ns_umount.sh /usr/bin/ns_umount
sudo cp ./ns_pull.sh /usr/bin/ns_pull
sudo cp ./ns_local.sh /usr/bin/ns_local
sudo cp ./ns_push.sh /usr/bin/ns_push
sudo cp ./ns_list.sh /usr/bin/ns_list
sudo cp ./ns_clog.sh /usr/bin/ns_clog
sudo cp ./ns_conflict.py /usr/bin/ns_conflict.py

sudo chmod +x /usr/bin/ns_variables
sudo chmod +x /usr/bin/netSync
sudo chmod +x /usr/bin/ns_init
sudo chmod +x /usr/bin/ns_cinterval
sudo chmod +x /usr/bin/ns_conflict
sudo chmod +x /usr/bin/ns_cleaner
sudo chmod +x /usr/bin/ns_mount
sudo chmod +x /usr/bin/ns_umount
sudo chmod +x /usr/bin/ns_pull
sudo chmod +x /usr/bin/ns_push
sudo chmod +x /usr/bin/ns_local
sudo chmod +x /usr/bin/ns_list
sudo chmod +x /usr/bin/ns_clog
sudo chmod +x /usr/bin/ns_conflict.py