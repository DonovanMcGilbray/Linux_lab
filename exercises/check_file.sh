#!/bin/bash
file="$1"
if[ -f "$file" ]; then 
  echo "$file exists. Lines: $(wc -l < "$file")"
else
  echo "$file does not exist. Creating..."
  touch "$file"
fi
