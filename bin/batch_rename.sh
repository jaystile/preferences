#!/bin/bash
# Script to help with bulk renaming of files. 
# This could be improved by accepting parameters.
# This could be improved by previewing the work to be done before executing
tmpfile=$(mktemp /tmp/batch_rename.sh.XXXXXX)
cleanup() {
	rm "$tmpfile"
}
trap cleanup 0 1 2 3 6 
postfix='.png'
prefix="./NewName_"
regex="./Image.*\\$postfix"
i=0

find . -type f -regex "$regex" -print0 >"$tmpfile"
while IFS= read -r -d ''; do
	num=$(echo $i | awk '{printf("%03d", $1)}')
	cmd="mv -v \"$REPLY\" \"$prefix$num$postfix\"" 
  eval "$cmd"
 	((i=i+1))
done <"$tmpfile"
