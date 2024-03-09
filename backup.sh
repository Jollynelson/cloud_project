#!/bin/bash

# Check if source and destination directories are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 source_directory destination_directory" 1>&2
  exit 1
fi

source_dir="$1"
destination_dir="$2"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Source directory '$source_dir' does not exist." 1>&2
  exit 1
fi

# Check if destination directory exists, if not, create it
if [ ! -d "$destination_dir" ]; then
  mkdir -p "$destination_dir"
fi

# Generate timestamp
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
backup_file="$destination_dir/backup_$timestamp.tar.gz"

# Create tar archive
tar -czf "$backup_file" "$source_dir"

echo "Backup created at: $backup_file"

