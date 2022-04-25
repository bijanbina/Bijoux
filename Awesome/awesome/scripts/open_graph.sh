#!/bin/bash

CHRM_ARG="--remote-debugging-port=9222 --window-size=920,400 --window-position=2900,650 "
nohup chromium $CHRM_ARG --app="https://github.com/bijanbina" & disown

reset
sleep 2
wmctrl -r "bijanbina (Bijan Binaee)" -b add,above

CURL_OUT=$(curl -s http://127.0.0.1:9222/json/list)
WS_URL=$(echo "$CURL_OUT" | grep -A 1 "https://github.com/bijanbina")
WS_URL=$(echo "$WS_URL" | grep "webSocket" | cut -d\" -f4)
#echo $WS_URL
cat cmd | websocat -n1 "$WS_URL" 2>/dev/null
