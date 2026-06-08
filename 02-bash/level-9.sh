#!/bin/bash

Directory="Arena"
logfile="Change_log.txt"

if [ ! -d $Directory ];then
	echo "Directory does not exist."
	exit 1
fi

inotifywait -mr "$Directory" | while read event; do
	if [ -e "$event" ];then
		echo "$(date +'%Y-%m-%d %H:%M:%S') File modified/created: $event" >> 


