#!/bin/sh
DISPLAY=":1"
HOME=/home/bijan/
XAUTHORITY=/run/user/1000/gdm/Xauthority
export DISPLAY XAUTHORITY HOME
#ckb --close
#sudo killall ckb-daemon
#echo "after kill"
#sleep 1
echo "after slip"
sudo ckb-daemon --hwload=always &
echo "after run"
sleep 3
sudo corsair.sh
