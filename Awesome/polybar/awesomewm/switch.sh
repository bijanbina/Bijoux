#!/bin/bash

TAG="$1"

#echo $TAG
SWITCH_CMD="awful = require('awful'); awful.screen.focused().tags"
awesome-client "$SWITCH_CMD[$1]:view_only()"


