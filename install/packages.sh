#!/bin/sh

# Check if a file argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <text_file>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Read the file line by line and join items with spaces
items=""
while IFS= read -r line || [ -n "$line" ]; do
    items="$items $line"
done < "$1"

# Output the items separated by spaces
sh -c "composer require $items"