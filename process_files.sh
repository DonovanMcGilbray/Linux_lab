#!/bin/bash
for i in 1 2 3; do
echo "File $i" > file_$i.txt
done
for file in *.txt; do
echo "Processing $file"
wc -l "$file"
done
