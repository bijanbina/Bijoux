#!/bin/bash
sudo corsair.sh
sudo mkdir /run/media/bijan/05559660-a641-4a23-b880-250c19048db1/
sudo mount /dev/sdb6 /run/media/bijan/05559660-a641-4a23-b880-250c19048db1/
/home/bijan/Project/Assistant/Sources/Assistant &
#desable automute in alsa and release sounds
amixer -c 0 sset "Auto-Mute Mode" Disabled
amixer -c 0 sset "Headphone" 100
amixer -c 0 sset "Headphone" on
xinput set-prop 12 "Device Accel Constant Deceleration" 1.5
xbindkeys
