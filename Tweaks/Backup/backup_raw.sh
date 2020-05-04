#! /bin/sh

IP_HOST=192.168.1.122
IP_SYSTEM1=192.168.1.131
IP_SYSTEM2=192.168.1.132
PATH_LOCAL=/mnt/hdd2/Backup

echo " ------------------- " >> "$PATH_LOCAL/log"

cd $PATH_LOCAL
if [ -f $PATH_LOCAL/host_list ]; then
	echo $(date "+%D %R") ": remove file" #>> "$PATH_LOCAL/log"
	rm host_list server1_list server2_list log1 log2
fi


if [ ! -d /tmp/system1/SVN ]; then
	echo $(date "+%D %R") ": Mount system1" #>> "$PATH_LOCAL/log"
	sudo mount -t cifs -o username=bijan,password=password //$IP_SYSTEM1/home /tmp/system1
fi
rsync -rutv --delete /tmp/system1/. "$PATH_LOCAL/server1/" >> "$PATH_LOCAL/log1"
echo $(date "+%D %R") ": rsync system1 completed" #>> "$PATH_LOCAL/log"

if [ ! -d /tmp/system2/SVN ]; then
	echo $(date "+%D %R") ": Mount system2" >> "$PATH_LOCAL/log"
	sudo mount -t cifs -o username=bijan,password=seed95 //$IP_SYSTEM2/home /tmp/system2
fi
rsync -rutv --delete /tmp/system2/. "$PATH_LOCAL/server2/" >> "$PATH_LOCAL/log2"
echo $(date "+%D %R") ": rsync system2 completed" #>> "$PATH_LOCAL/log"


cd "$PATH_LOCAL/host"
find . > ../host_list
cd "$PATH_LOCAL/server1"
find . > ../server1_list
cd "$PATH_LOCAL/server2"
find . > ../server2_list

while read p; do
	cd "$PATH_LOCAL"
	CHECK_FILE=$(grep "$p" server2_list)
	if [ -z "$CHECK_FILE" ]; then
		echo $(date "+%D %R") ": delete file $p" #>> "$PATH_LOCAL/log"
		cd "$PATH_LOCAL/host"
		rm -dr "$p"
		cd "$PATH_LOCAL/server1"
		rm -dr "$p"
	fi
	cd "$PATH_LOCAL"
	CHECK_FILE=$(grep "$p" server1_list)
	if [ -z "$CHECK_FILE" ]; then
		echo $(date "+%D %R") ": delete file $p" #>> "$PATH_LOCAL/log"
		cd "$PATH_LOCAL/host"
		rm -dr "$p"
		cd "$PATH_LOCAL/server2"
		rm -dr "$p"
	fi
done <"$PATH_LOCAL/host_list"

echo "start copy from local server1 to host"
cp -rupv "$PATH_LOCAL/server1/." "$PATH_LOCAL/host/" >> "$PATH_LOCAL/log1"

echo "start copy from local server2 to host"
cp -rupv "$PATH_LOCAL/server2/." "$PATH_LOCAL/host/" >> "$PATH_LOCAL/log2"

echo "start copy from host to local server1"
rsync -rutv --delete "$PATH_LOCAL/host/." "$PATH_LOCAL/server1/" >> "$PATH_LOCAL/log1"

echo "start copy from host to local server2"
rsync -rutv --delete "$PATH_LOCAL/host/." "$PATH_LOCAL/server2/" >> "$PATH_LOCAL/log2"

echo "start copy from host to Bijan-Windows"
sudo rsync -rutv --delete "$PATH_LOCAL/host/." /tmp/system1 >> "$PATH_LOCAL/log1"

echo "start copy from host to Bijan-Portable"
sudo rsync -rutv --delete "$PATH_LOCAL/host/." /tmp/system2 >> "$PATH_LOCAL/log2"

echo "go to sleep"
# sleep 1800 #30 min
wait
