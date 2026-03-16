#!/bin/bash
hosts=("localhost" "127.0.0.1")
timestamp=$(date +%Y%m%d_%H%M%S)
for h in "${hosts[@]}"; do
  if ping -c 1 "$h" > /dev/null; then
    echo "$h: up" >> ping_log_$timestamp.txt
  else
    echo "$h: down" >> ping_log_$timestamp.txt
  fi
done
