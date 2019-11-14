#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

PULL_REQUESTS=$(cat pulls.json | jq '.[].number')
for PULL_REQUEST in $PULL_REQUESTS
do
  ./pull_get_each.sh ${PULL_REQUEST}
done