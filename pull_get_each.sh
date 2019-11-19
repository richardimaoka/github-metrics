#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

PULL_REQUEST_NUMBER=$1

# -r flag to strip the double quotes
GIHUB_TOKEN=$(jq -r '.github_token' env.json)
GITHUB_ORGANIZATION=$(jq  -r '.github_organization' env.json)
GITHUB_REPOSITORY=$(jq  -r '.github_repository' env.json)

mkdir -p pulls

while true
do
  JSON_FILENAME="pulls/${PULL_REQUEST_NUMBER}.json"
  
  # 2>/dev/null to discard curl's in-progress stats
  curl \
    -H "Authorization: token ${GIHUB_TOKEN}" \
    "https://api.github.com/repos/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/pulls/${PULL_REQUEST_NUMBER}" 2>/dev/null \
    > "${JSON_FILENAME}"
  
  ERROR_MESSAGE=$(jq -r '.message' "${JSON_FILENAME}")
  if [ "${ERROR_MESSAGE}" = "Not Found" ]; then
    >&2 echo "ERROR: Not found. ${PULL_REQUEST_NUMBER} is most likely an issue, not a pull request."
    rm "${JSON_FILENAME}"
    exit 1

  # TOO bad!! jq returns "null" = 'n'+'u'+'l'+'l' String for a non-existent value https://github.com/stedolan/jq/issues/354
  elif [ "${ERROR_MESSAGE}" != "null" ]; then
    >&2 echo "ERROR: ${ERROR_MESSAGE}"
    exit 1

  else
    # Successful
    exit 0
  fi
done
