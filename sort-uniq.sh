#!/bin/bash

# Input file (change this to your actual file)
INPUT_FILE="domains.txt"
# Output file
OUTPUT_FILE="domains_sorted_unique.txt"

# Empty the output file first
> "$OUTPUT_FILE"

# Sort and remove duplicates
sort "$INPUT_FILE" | uniq > "$OUTPUT_FILE"

echo "Sorted and removed duplicates. Output saved to $OUTPUT_FILE"
