#!/bin/bash

INPUT_FILE="domains.txt"
OUTPUT_FILE="resolved.txt"

# Empty the output file if it exists
> "$OUTPUT_FILE"

while IFS= read -r domain || [ -n "$domain" ]; do
    # Skip empty lines
    [[ -z "$domain" ]] && continue

    # Get the first IPv4 address using dig
    ip=$(dig +short "$domain" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n1)

    # If IP is found, write the formatted result
    if [[ -n "$ip" ]]; then
        echo "||${domain}^\$dnsrewrite=${ip}" >> "$OUTPUT_FILE"
    else
        echo "||${domain}^\$dnsrewrite=IP_NOT_FOUND" >> "$OUTPUT_FILE"
    fi
done < "$INPUT_FILE"
