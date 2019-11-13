#!/bin/sh

ISSUE_NUMBER=$1
GIHUB_TOKEN=$2
ORG_REPO=$3

curl -H "Authorization: token ${GIHUB_TOKEN}" "https://api.github.com/repos/${ORG_REPO}/issues/${ISSUE_NUMBER}"