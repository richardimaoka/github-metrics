#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

# -r flag to strip the double quotes
GIHUB_TOKEN=$(jq -r '.github_token' env.json)
GITHUB_ORGANIZATION=$(jq  -r '.github_organization' env.json)
GITHUB_REPOSITORY=$(jq  -r '.github_repository' env.json)

PULL_REQUEST_NUMBER=$1

mkdir -p pulls

# 2>/dev/null to discard curl's in-progress stats
JSON=$(curl \
  -H "Authorization: token ${GIHUB_TOKEN}" \
  "https://api.github.com/repos/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/pulls/${PULL_REQUEST_NUMBER}" 2>/dev/null)

ERROR_MESSAGE=$(echo "${JSON}" | jq -r '.message')
if [ "${ERROR_MESSAGE}" = "Not Found" ] ; then
  >&2 echo "Not found, pull request ${PULL_REQUEST_NUMBER}"
  exit 1
else
  echo "${JSON}"> pulls/"${PULL_REQUEST_NUMBER}.json"
fi