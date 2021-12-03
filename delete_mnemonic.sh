#!/bin/env bash
echo "****** sleeping 5m... ******"
sleep 5m

for d in "$HOME"/.coctohug*/ ; do
    filename="$d"mnc.txt
    echo '' > "$filename"
    echo "$filename has been removed"
done