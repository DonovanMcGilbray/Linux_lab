#!/bin/bash
backup_dir() {
local src=$1
local dst=$2
if [ -d "$src" ]; then
cp -r "$src" "${dst}_backup"
echo "Backed up $src to ${dst}_backup"
else
echo "Error: $src doesn't exist"
return 1
fi
}
backup_dir ~/cs_projects ~/cs_projects_backup
