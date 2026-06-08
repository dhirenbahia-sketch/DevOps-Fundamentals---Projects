#!/bin/bash

{

mkdir -p Battlefield
touch Battlefield/{knight,sorcerer,rogue}.txt

if [[ -f Battlefield/knight.txt ]]; then

	mkdir -p Archive && mv Battlefield/knight.txt Archive/
fi
echo "Contents of Battlefield:"
ls Battlefield

echo "Contents of Archive:"
ls Archive

}
