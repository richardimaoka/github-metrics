#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

echo "issue,created_at,closed_at"

PULL_REQUESTS=$(ls pulls)
for PULL_REQUEST in $PULL_REQUESTS
do
  ./extract.sh pulls/${PULL_REQUEST}
done