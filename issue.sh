#!/bin/sh

GIHUB_TOKEN=$1
ORG_REPO=$2
ISSUE_NUMBER=$3

curl -H "Authorization: token ${GIHUB_TOKEN}" "https://api.github.com/repos/${ORG_REPO}/issues/${ISSUE_NUMBER}"