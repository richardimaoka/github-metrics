#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

# -r flag to strip the double quotes
GIHUB_TOKEN=$(jq -r '.github_token' env.json)
GITHUB_ORGANIZATION=$(jq  -r '.github_organization' env.json)
GITHUB_REPOSITORY=$(jq  -r '.github_repository' env.json)

PULL_REQUEST_NUMBER=$1

curl \
  -H "Authorization: token ${GIHUB_TOKEN}" \
  "https://api.github.com/repos/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/pulls/${PULL_REQUEST_NUMBER}" \
  > "${PULL_REQUEST_NUMBER}.json"