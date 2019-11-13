#!/bin/sh

FILE_NAME=$1

ISSUE_NUMBER=$(cat ${FILE_NAME} | jq '.number')
CREATED_AT=$(cat ${FILE_NAME} | jq '.created_at')
CLOSED_AT=$(cat ${FILE_NAME} | jq '.closed_at')

# e.g.) 2019-09-30T04:33:10Z -> 2019/09/30 04:33:10
# | sed 's/-/\//g': 2019-10-01  -> 2019/10/01
# | sed 's/Z//g'  : 04:33:10Z   -> 04:33:10
# | sed 's/T/ /g' : 2019-09-30T -> 2019-09-30
CREATED_AT_FORMATTED=$(echo $CREATED_AT | sed 's/-/\//g' | sed 's/Z//g' | sed 's/T/ /g') 
CLOSED_AT_FORMATTED=$(echo $CLOSED_AT | sed 's/-/\//g' | sed 's/Z//g' | sed 's/T/ /g')

echo "${ISSUE_NUMBER},${CREATED_AT_FORMATTED},${CLOSED_AT_FORMATTED}"