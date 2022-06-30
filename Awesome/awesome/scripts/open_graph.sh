#!/bin/bash

PC_NAME=$(hostname)
if [[ "$PC_NAME" == "Bijan-UX390" ]]; then
	W_POS="--window-position=900,650"
else
	W_POS="--window-position=2900,650"
fi
CHRM_ARG="--remote-debugging-port=9232 --window-size=920,400 $W_POS"
chromium $CHRM_ARG --app="https://github.com/bijanbina" 2>/dev/null & disown

sleep 3
xdotool key --delay 150 Super_L+k
reset
wmctrl -r "bijanbina (Bijan Binaee)" -b add,above

CURL_OUT=$(curl -s http://127.0.0.1:9232/json/list)
WS_URL=$(echo "$CURL_OUT" | grep -A 1 "https://github.com/bijanbina")
WS_URL=$(echo "$WS_URL" | grep "webSocket" | cut -d\" -f4)
#echo $WS_URL
cat cmd | websocat -n1 "$WS_URL" 2>/dev/null >/dev/null
