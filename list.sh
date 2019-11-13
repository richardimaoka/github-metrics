#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

ISSUES=$(cat all.json | jq '.[].number')
for ISSUE in $ISSUES
do
  ./issue ISSUE
done