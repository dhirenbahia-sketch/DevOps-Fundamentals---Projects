#!/bin/bash



if [[ $# -eq 0 ]]; then
	echo "No file provided."
elif [[ $# -eq 1 ]];then
	
	result=$(wc -l "$1")
	echo "Number of lines in $1: $result"

else 
	echo "Too many files attached"

fi 	
