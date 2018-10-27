#!/bin/sh
DISPLAY=":0" #FIXME: Get display ID based on opened terminal
HOME=/home/bijan/
XAUTHORITY=/run/user/1000/gdm/Xauthority
export DISPLAY XAUTHORITY HOME
#ckb --close
#sudo killall ckb-daemon
#echo "after kill"
#sleep 1
echo "after sleep with XAUTHORITY=$XAUTHORITY DISPLAY=$DISPLAY"
sudo ckb-daemon --hwload=always &
echo "after run"
sleep 3
sudo corsair.sh
echo "corsair start done"
