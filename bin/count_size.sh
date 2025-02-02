#!/bin/bash
# Utility that prints the disk usage size from the current directory and subdirectories
OIFS="$IFS"
IFS=$'\n'
for d in $(find . -maxdepth 1 -type d | sort ); do
	count=$(ls -a  "$d" | wc -l)
	size=$(du -sh "$d")
  echo "$count $size $d"
done
IFS="$OIFS"
