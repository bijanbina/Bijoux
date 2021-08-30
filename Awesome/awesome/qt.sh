#!/bin/bash


TAG="4"

BATOOL="qtcreator ~/Project/Benjamin/Tools/BaTool.pro"
REBOND="qtcreator ~/Project/RAIIS/Rebound/Rebound.pro"


awesome-client "awful = require('awful'); screen[2].tags[$TAG]:view_only()"
awesome-client "awful = require('awful'); screen[1].tags[$TAG]:view_only()"

awesome-client "spawn_tag('$BATOOL', screen[2].tags[$TAG])"
sleep 2
awesome-client "spawn_tag('$REBOND', screen[1].tags[$TAG])"
