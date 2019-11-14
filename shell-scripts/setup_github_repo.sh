#!/bin/sh

######################################################################################
#
# Syntax: 'setup_github_repo.sh {GITHUB_ORGANIZATION} {GITHUB_REPOSITORY}'
#
######################################################################################

###########################################
# Parse options and pre-condition check
###########################################
GITHUB_ORGANIZATION=$1
if [ -z "$GITHUB_ORGANIZATION" ]; then
  echo "ERROR: Option {GITHUB_ORGANIZATION} is missing in the expected syntax : 'setup_github_repo.sh {GITHUB_ORGANIZATION} {GITHUB_REPOSITORY}'"
  IS_ERROR=1
fi

GITHUB_REPOSITORY=$2
if [ -z "$GITHUB_REPOSITORY" ]; then
  echo "ERROR: Option {GITHUB_REPOSITORY} is missing in the expected syntax   : 'setup_github_repo.sh {GITHUB_ORGANIZATION} {GITHUB_REPOSITORY}'"
  IS_ERROR=1
fi

GIHUB_TOKEN=$(jq -r '.github_token' env.json)
if [ -z "$GIHUB_TOKEN" ]; then
  echo "ERROR: GitHub personal token not found. Set it up in env.json, modeled after env.default.json."
  IS_ERROR=1
fi

if [ -n "$IS_ERROR" ]; then
  exit 1
fi

###########################################
# Check if the given repository exists
###########################################

# 2>/dev/null to discard curl's in-progress packet stats
REPO_INFO=$(curl \
  -H "Authorization: token ${GIHUB_TOKEN}" \
  "https://api.github.com/repos/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}" 2>/dev/null)

REPO_FULL_NAME=$(echo "${REPO_INFO}" | jq -r '.full_name')
if [ "${REPO_FULL_NAME}" != "${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}" ] ; then
  echo "ERROR: Failed to retrieve the GitHub info of ${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}."
  echo "${REPO_INFO}"
  exit 1
fi

###########################################
# Set up the data directory
###########################################
mkdir -p data/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}

# echo "{" > data/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/env.json
# echo "  \"github_token\": \"\${GIHUB_TOKEN}" > data/${GIHUB_TOKEN}/${GITHUB_REPOSITORY}/env.json
# echo "  \"github_repository\": \"\${GIHUB_TOKEN}" > data/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/env.json
# echo "  \"github_organization\": \"\${GIHUB_TOKEN}" > data/${GITHUB_REPOSITORY}/${GITHUB_REPOSITORY}/env.json
# echo "}" > data/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/env.json
