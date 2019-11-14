#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

# -r flag to strip the double quotes
GIHUB_TOKEN=$(cat env.json | jq -r '.github_token')
GITHUB_ORGANIZATION=$(cat env.json | jq  -r '.github_organization')
GITHUB_REPOSITORY=$(cat env.json | jq  -r '.github_repository')

ISSUE_NUMBER=$1

curl \
  -H "Authorization: token ${GIHUB_TOKEN}" \
  "https://api.github.com/repos/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/issues/${ISSUE_NUMBER}" \
  > "${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/${ISSUE_NUMBER}.json"