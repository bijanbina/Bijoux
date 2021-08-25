#!/bin/bash

if [[ "$1" == "8" ]];then

	awesome-client 'awful = require("awful"); awful.tag.viewnext()'

elif [[ "$1" == "9" ]];then

	awesome-client 'awful = require("awful"); awful.tag.viewprev()'

fi
