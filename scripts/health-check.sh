#!/bin/bash

URL=$1

if [ -z "$URL" ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
TIMESTAMP=$(date)

if [ "$STATUS" -ge 200 ] && [ "$STATUS" -lt 400 ]; then
    RESULT="HEALTHY"
    EXIT_CODE=0
else
    RESULT="UNHEALTHY"
    EXIT_CODE=1
fi

echo "$TIMESTAMP | $URL | HTTP $STATUS | $RESULT"

mkdir -p logs
echo "$TIMESTAMP | $URL | HTTP $STATUS | $RESULT" >> logs/health-check.log

exit $EXIT_CODE
