#!/bin/bash

{


result=$(find /home/ec2-user/DevOps-Fundamentals---Projects/02-bash/Arena hero.txt 2>/dev/null )
if [[ -n "$result" ]]; then
	
	
	echo "Hero missing!"
else
	echo "Hero found!"
fi

}
