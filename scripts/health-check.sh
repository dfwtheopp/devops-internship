#!/bin/bash

URL="$1"
LOG_FILE="logs/health-check.log"

if [ -z "$URL" ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

RESULT=$(curl -o /dev/null -s -w "%{http_code} %{time_total}" \
    --connect-timeout 5 "$URL")

HTTP_STATUS=$(echo "$RESULT" | awk '{print $1}')
RESPONSE_TIME=$(echo "$RESULT" | awk '{print $2}')

if [ "$HTTP_STATUS" -ge 200 ] && [ "$HTTP_STATUS" -lt 400 ]; then
    STATUS="HEALTHY"
    EXIT_CODE=0
else
    STATUS="UNHEALTHY"
    EXIT_CODE=1
fi

echo "$TIMESTAMP | $URL | HTTP $HTTP_STATUS | ${RESPONSE_TIME}s | $STATUS"

echo "$TIMESTAMP | $URL | HTTP $HTTP_STATUS | ${RESPONSE_TIME}s | $STATUS" >> "$LOG_FILE"

exit "$EXIT_CODE"