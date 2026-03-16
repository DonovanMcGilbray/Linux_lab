#!/bin/bash
src="$1"
dest="$2"
timestamp=$(date +%Y%m%d_%H%M%S)
mkdir -p "$dest"
cp -r "$src" "$dest/backup_$timestamp"
echo "Backup of $src saved to $dest/backup_$timestamp"
