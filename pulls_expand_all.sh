#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

# GitHub API's 'List pull requests' endpoint (https://developer.github.com/v3/pulls/#list-pull-requests)
# only returns 30 pull requests.
# So we are using the following "brute-force" while loop to find all pull requests up to the latest one.
PULL_REQUEST_LATEST=$(./pull_latest.sh | jq -r '.number')

# brute-force: increment from 1 to latest
PULL_REQUEST_NUMBER=1
while [ "${PULL_REQUEST_NUMBER}" -lt "${PULL_REQUEST_LATEST}" ]
do
  echo "${PULL_REQUEST_NUMBER}"
  ./pull_get_each.sh "${PULL_REQUEST_NUMBER}"
  PULL_REQUEST_NUMBER=$((PULL_REQUEST_NUMBER + 1))
done