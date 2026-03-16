#!/bin/bash
total=0
for f in *.txt; do
    [ -f "$f" ] || continue
    lines=$(wc -l < "$f")
    total=$((total + lines))
done
echo "Total lines in all .txt files: $total"
