#!/bin/bash

TAG="$1"

#echo $TAG
#SWITCH_CMD="awful = require('awful'); awful.screen.focused().tags"

if [[ "$TAG" == "next" ]]; then

	SWITCH_CMD="awful = require('awful'); awful.tag.viewnext(screen[2])"
	awesome-client "$SWITCH_CMD"

	SWITCH_CMD="awful = require('awful'); awful.tag.viewnext(screen[1])"
	awesome-client "$SWITCH_CMD"

elif [[ "$TAG" == "prev" ]]; then

	SWITCH_CMD="awful = require('awful'); awful.tag.viewprev(screen[2])"
	awesome-client "$SWITCH_CMD"

	SWITCH_CMD="awful = require('awful'); awful.tag.viewprev(screen[1])"
	awesome-client "$SWITCH_CMD"

else

	SWITCH_CMD="awful = require('awful'); screen[2].tags"
	awesome-client "$SWITCH_CMD[$1]:view_only()"

	SWITCH_CMD="awful = require('awful'); screen[1].tags"
	awesome-client "$SWITCH_CMD[$1]:view_only()"

fi
