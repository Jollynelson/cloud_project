#!/bin/bash

# Default value for top N entries
topN=8

# Parse command line arguments
while getopts ":dn:" opt; do
  case ${opt} in
    d )
      list_all=true
      ;;
    n )
      topN=$OPTARG
      ;;
    \? )
      echo "Usage: $0 [-d] [-n N] directory" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Check if the directory argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 [-d] [-n N] directory" 1>&2
  exit 1
fi

directory="$1"

# Check if directory exists
if [ ! -d "$directory" ]; then
  echo "Directory '$directory' does not exist." 1>&2
  exit 1
fi

# Command to list disk usage
if [ "$list_all" = true ]; then
  du -ah "$directory" 2>/dev/null | sort -rh | head -n "$topN"
else
  du -h --max-depth=1 "$directory" 2>/dev/null | sort -rh | head -n "$topN"
fi

