#!/bin/bash

MODEL_NAME="Logitech G502 HERO Gaming Mouse"
XINPUT_LINE=$(xinput | grep "$MODEL_NAME" | grep -v "Keyboard")
MOUSE_ID=$(echo $XINPUT_LINE | awk '{print $8}' | cut -d= -f2)

xinput set-prop $MOUSE_ID "Coordinate Transformation Matrix" 0.75 0.000000 0.000000 0.000000 0.75 0.000000 0.000000 0.000000 1.000000
xset m 1 1
