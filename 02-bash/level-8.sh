OD#!/bin/bash

if [ -z "$1" ];then
	echo "A phrase or word has not been included"
	exit 1	
fi 

if [ ! -d "$2" ];then
	echo "$2 Directory does not exist"
	exit 1
fi
 
grep -r "$1" "$2" --include="*.log"
