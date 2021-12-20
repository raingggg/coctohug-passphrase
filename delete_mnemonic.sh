#!/bin/env bash
echo "****** sleeping 10m... ******"
sleep 10m

for d in "$HOME"/.coctohug*/ ; do
    filename="$d"mnc.txt
    echo '' > "$filename"
    echo "$filename has been removed"
done