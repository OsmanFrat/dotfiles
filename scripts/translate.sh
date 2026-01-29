#!/usr/bin/env bash

word="${1:-$(wl-paste -p 2>/dev/null || wl-paste 2>/dev/null)}"

if [[ -z "$word" || "$word" =~ [\/[:space:]] ]]; then
  notify-send -u critical -t 3000 "Invalid input"
  exit 0
fi

# API request (IPv4 forced)
response=$(curl -4 -sS --connect-timeout 5 --max-time 10 \
  -w "\n%{http_code}" \
  "https://api.dictionaryapi.dev/api/v2/entries/en_US/$word")

body=$(echo "$response" | sed '$d')
status=$(echo "$response" | tail -n1)

# HTTP error
if [[ "$status" != "200" ]]; then
  notify-send -u critical -t 3000 "Connection error" "HTTP $status"
  exit 1
fi

# Invalid word
if grep -q "No Definitions Found" <<< "$body"; then
  notify-send -u critical -t 3000 "Invalid word"
  exit 0
fi

definitions=$(echo "$body" | jq -r '
  [.[0].meanings[]
   | {pos: .partOfSpeech, def: .definitions[0].definition}]
  | .[:3]
  | map("\(.pos): \(.def)")
  | join("\n\n")
')

notify-send -t 60000 "$word" "$definitions"

