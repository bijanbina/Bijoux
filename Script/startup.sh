#!/bin/bash
set -x
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/tmp/startup_log 2>&1
# Everything below will go to the file 'log.out':
xbindkeys &
sudo mkdir /run/media/bijan/05559660-a641-4a23-b880-250c19048db1/
sudo mkdir /run/media/bijan/0DECD1C53869ECB0/
sudo mount /dev/sdb6 /run/media/bijan/05559660-a641-4a23-b880-250c19048db1/
sudo mount /dev/sda4 /run/media/bijan/0DECD1C53869ECB0/
/home/bijan/Project/Assistant/Sources/Assistant &
#desable automute in alsa and release sounds
amixer -c 0 sset "Auto-Mute Mode" Disabled
amixer -c 0 sset "Headphone" 100
amixer -c 0 sset "Headphone" on
#xinput set-prop 12 "Device Accel Constant Deceleration" 1.5
xinput set-prop 9 "Device Accel Constant Deceleration" 1.4
sudo cpupower frequency-set -d 2.5GHz
#FIXME (START)
#xbindkeys & need to run as bijan (currently run as root)
#Error : /root/.xbindkeysrc not found or reading not allowed.
#FIXME (END)
echo "hi"
sudo /usr/bin/systemctl start nmbd.service
/home/bijan/Project/Bijoux/Tweaks/Mice/mouse-suspend.sh
#vmware
sudo /home/bijan/Project/Bijoux/Script/startup_root.sh
