#!/bin/env bash
echo "****** sleeping 5m... ******"
sleep 5m

for d in "$HOME"/.coctohug-*/ ; do
    filename="$d"mnemonic.txt
    rm -f "$filename"
    echo "$filename has been removed"
done