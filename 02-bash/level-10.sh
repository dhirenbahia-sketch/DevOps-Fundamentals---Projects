#!/bin/bash


mkdir Arena_Boss
touch Arena_Boss/{file1,file2,file3,file4,file5}.txt

for file in Arena_Boss/*.txt; do
	number=$(( RANDOM % 11 + 10 ))
	for i in $(seq 1 $number); do	
			echo "This is line $i" >> $file
	done
done


list=$(ls -lshr Arena_Boss/*.txt)
echo "$list"

mkdir -p Victory_Archive

files=$(grep -rl "Victory" Arena_Boss/)
if [[ -n "$files" ]]; then
        mv $files Victory_Archive/
        echo "Files moved to Victory_Archive: $files"
else
        echo "No files containing Victory found"
fi
