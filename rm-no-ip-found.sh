#!/bin/bash

# Script to remove lines ending with IP_NOT_FOUND from file2.txt 
# and corresponding lines from file1.txt

FILE1="file1.txt"
FILE2="file2.txt"
TEMP1="temp1.txt"
TEMP2="temp2.txt"

# Check if both files exist
if [[ ! -f "$FILE1" ]]; then
    echo "Error: $FILE1 not found!"
    exit 1
fi

if [[ ! -f "$FILE2" ]]; then
    echo "Error: $FILE2 not found!"
    exit 1
fi

# Get line numbers that end with IP_NOT_FOUND in file2.txt
lines_to_delete=$(grep -n "IP_NOT_FOUND$" "$FILE2" | cut -d: -f1)

if [[ -z "$lines_to_delete" ]]; then
    echo "No lines ending with IP_NOT_FOUND found in $FILE2"
    exit 0
fi

echo "Found lines to delete: $(echo $lines_to_delete | tr '\n' ' ')"

# Create temporary files without the matching lines
# We need to process in reverse order to maintain correct line numbers
for line_num in $(echo "$lines_to_delete" | sort -nr); do
    # Remove line from file1.txt
    sed "${line_num}d" "$FILE1" > "$TEMP1" && mv "$TEMP1" "$FILE1"
    
    # Remove line from file2.txt  
    sed "${line_num}d" "$FILE2" > "$TEMP2" && mv "$TEMP2" "$FILE2"
    
    echo "Deleted line $line_num from both files"
done

echo "Operation completed successfully!"
echo "Lines ending with IP_NOT_FOUND have been removed from both files."
