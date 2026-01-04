#!/bin/bash
# loadtest.sh
# Usage: ./loadtest.sh BOOK_ID NB_REQUESTS

BOOK_ID=$1
REQUESTS=$2

if [ -z "$BOOK_ID" ] || [ -z "$REQUESTS" ]; then
  echo "Usage: ./loadtest.sh BOOK_ID NB_REQUESTS"
  exit 1
fi

echo "Sending $REQUESTS concurrent purchase requests for Book ID $BOOK_ID..."

for ((i=1; i<=REQUESTS; i++)); do
  curl -X POST "http://localhost:8082/api/books/$BOOK_ID/purchase" \
       -H "Content-Type: application/json" \
       --silent --output /dev/null &
done

wait
echo "All requests sent."
