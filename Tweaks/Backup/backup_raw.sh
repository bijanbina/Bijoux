#! /bin/sh

IP_HOST=192.168.1.122
IP_SYSTEM1=192.168.1.131
IP_SYSTEM2=192.168.1.132
PATH_LOCAL=/mnt/hdd2/Backup

echo " ------------------- " >> "$PATH_LOCAL/log"

cd $PATH_LOCAL
if [ -f $PATH_LOCAL/host_list ]; then
	echo $(date "+%D %R") ": remove file" >> "$PATH_LOCAL/log"
	rm host_list server1_list server2_list log1 log2 rm_dir
fi

if [ ! -d /tmp/system1/SVN ]; then
	echo $(date "+%D %R") ": Mount system1" >> "$PATH_LOCAL/log"
	sudo mount -t cifs -o username=bijan,password=password //$IP_SYSTEM1/home /tmp/system1
fi
if [ ! -d /tmp/system1/SVN ]; then
	echo $(date "+%D %R") ": Mount system1 failed!!!" >> "$PATH_LOCAL/log"
	sleep 900 #15 min
	exit
fi

rsync -rutv --delete /tmp/system1/. "$PATH_LOCAL/server1/" >> "$PATH_LOCAL/log1"
echo $(date "+%D %R") ": rsync system1 completed" >> "$PATH_LOCAL/log"

if [ ! -d /tmp/system2/SVN ]; then
	echo $(date "+%D %R") ": Mount system2" >> "$PATH_LOCAL/log"
	sudo mount -t cifs -o username=bijan,password=seed95 //$IP_SYSTEM2/home /tmp/system2
fi
if [ ! -d /tmp/system2/SVN ]; then
	echo $(date "+%D %R") ": Mount system2 failed!!!" >> "$PATH_LOCAL/log"
	sleep 900 #15 min
	exit
fi

rsync -rutv --delete /tmp/system2/. "$PATH_LOCAL/server2/" >> "$PATH_LOCAL/log2"
echo $(date "+%D %R") ": rsync system2 completed" >> "$PATH_LOCAL/log"

# Delete All spurious file in server1
echo $(date "+%D %R") ": delete extra files in server1" >> "$PATH_LOCAL/log"
cd "$PATH_LOCAL/server1"
find . \( -name "*.lck*" -o -name "*.jrl*" -o -name "*.err*" -o -name "*.log*" -o -name "*.dml*" -o -name "*.iml*" \) -type f -delete
find . -name "signoise.run" -type d > "$PATH_LOCAL/rm_dir"
echo $(date "+%D %R") ": delete signoise.run folder in server1" >> "$PATH_LOCAL/log"
while read p; do
	rm -rd "$p"
done <"$PATH_LOCAL/rm_dir"
find . -name "sigxp.run" -type d > "$PATH_LOCAL/rm_dir"
echo $(date "+%D %R") ": delete sigxp.run folder in server1" >> "$PATH_LOCAL/log"
while read p; do
	rm -rd "$p"
done <"$PATH_LOCAL/rm_dir"


# Delete All spurious file in server2
echo $(date "+%D %R") ": delete extra files in server2" >> "$PATH_LOCAL/log"
cd "$PATH_LOCAL/server2"
find . \( -name "*.lck*" -o -name "*.jrl*" -o -name "*.err*" -o -name "*.log*" -o -name "*.dml*" -o -name "*.iml*" \) -type f -delete
find . -name "signoise.run" -type d > "$PATH_LOCAL/rm_dir"
echo $(date "+%D %R") ": delete signoise.run folder in server2" >> "$PATH_LOCAL/log"
while read p; do
	rm -rd "$p"
done <"$PATH_LOCAL/rm_dir"
find . -name "sigxp.run" -type d > "$PATH_LOCAL/rm_dir"
echo $(date "+%D %R") ": delete sigxp.run folder in server2" >> "$PATH_LOCAL/log"
while read p; do
	rm -rd "$p"
done <"$PATH_LOCAL/rm_dir"

cd "$PATH_LOCAL/host"
find . > ../host_list

cd "$PATH_LOCAL/server1"
find . > ../server1_list

cd "$PATH_LOCAL/server2"
find . > ../server2_list

echo $(date "+%D %R") ": sync local server1-2, host" >> "$PATH_LOCAL/log"
while read p; do
	cd "$PATH_LOCAL"
	CHECK_FILE=$(grep "$p" server2_list)
	if [ -z "$CHECK_FILE" ]; then
		echo $(date "+%D %R") ": delete file $p that deleted from server2" >> "$PATH_LOCAL/log"
		
		cd "$PATH_LOCAL/host"
		cp -rupv "$p" "$PATH_LOCAL/delete"
		rm -dr "$PATH_LOCAL/host/$p"
		
		cd "$PATH_LOCAL/server1"
		cp -rupv "$p" "$PATH_LOCAL/delete"
		rm -dr "$PATH_LOCAL/server1/$p"
	fi
	cd "$PATH_LOCAL"
	CHECK_FILE=$(grep "$p" server1_list)
	if [ -z "$CHECK_FILE" ]; then
		echo $(date "+%D %R") ": delete file $p that deleted from server1" >> "$PATH_LOCAL/log"
		
		cd "$PATH_LOCAL/host"
		cp -rupv "$p" "$PATH_LOCAL/delete"
		rm -dr "$PATH_LOCAL/host/$p"
		
		cd "$PATH_LOCAL/server2"
		cp -rupv "$p" "$PATH_LOCAL/delete"
		rm -dr "$PATH_LOCAL/server2/$p"
	fi
done <"$PATH_LOCAL/host_list"

echo "start copy from local server1 to host" >> "$PATH_LOCAL/log"
cp -rupv "$PATH_LOCAL/server1/." "$PATH_LOCAL/host/" >> "$PATH_LOCAL/log1"

echo "start copy from local server2 to host" >> "$PATH_LOCAL/log"
cp -rupv "$PATH_LOCAL/server2/." "$PATH_LOCAL/host/" >> "$PATH_LOCAL/log2"

echo "start copy from host to local server1" >> "$PATH_LOCAL/log"
rsync -rutv --delete "$PATH_LOCAL/host/." "$PATH_LOCAL/server1" >> "$PATH_LOCAL/log1"

echo "start copy from host to local server2" >> "$PATH_LOCAL/log"
rsync -rutv --delete "$PATH_LOCAL/host/." "$PATH_LOCAL/server2" >> "$PATH_LOCAL/log2"

echo "start copy from host to Bijan-Windows" >> "$PATH_LOCAL/log"
sudo rsync -rutv --delete "$PATH_LOCAL/host/." /tmp/system1 >> "$PATH_LOCAL/log1"

echo "start copy from host to Bijan-Portable" >> "$PATH_LOCAL/log"
sudo rsync -rutv --delete "$PATH_LOCAL/host/." /tmp/system2 >> "$PATH_LOCAL/log2"

echo "go to sleep" >> "$PATH_LOCAL/log"
sleep 1800 #30 min
wait
