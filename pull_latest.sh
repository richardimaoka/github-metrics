#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

# -r flag to strip the double quotes
GIHUB_TOKEN=$(jq -r '.github_token' env.json)
GITHUB_ORGANIZATION=$(jq  -r '.github_organization' env.json)
GITHUB_REPOSITORY=$(jq  -r '.github_repository' env.json)

# About the URL query parameters:
#   state=closed to analyze completed items,
#   sort=created&direction=desc to get the latest pull request by `jq -r .[0]`
#
# 2>/dev/null to discard curl's in-progress stats
curl \
  -H "Authorization: token ${GIHUB_TOKEN}" \
  "https://api.github.com/repos/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/pulls?state=closed&sort=created&direction=desc" 2>/dev/null \
  | jq -r '.[0]'