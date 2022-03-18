#!/bin/bash

IS_ON=$(ifconfig | grep tun0 | wc -l)

if [[ "$IS_ON" == "1" ]]; then

	sudo pkill openconnect

elif [[ "$IS_ON" == "0" ]]; then

	echo "48868" | sudo openconnect c2.kmak.us:443 -u km93057 --passwd-on-stdin --reconnect-timeout 5 &

fi
