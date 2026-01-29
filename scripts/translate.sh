#!/usr/bin/env bash

# Word priority:
# 1) argument
# 2) primary selection
# 3) clipboard
word="${1:-$(wl-paste -p 2>/dev/null || wl-paste 2>/dev/null)}"

# Empty or invalid input check
if [[ -z "$word" || "$word" =~ [\/[:space:]] ]]; then
  notify-send -u critical -t 3000 "Invalid input"
  exit 0
fi

# API request
query=$(curl -fsS --connect-timeout 5 --max-time 10 \
  "https://api.dictionaryapi.dev/api/v2/entries/en/$word")

# Curl error
if [[ $? -ne 0 || -z "$query" ]]; then
  notify-send -u critical -t 3000 "Connection error"
  exit 1
fi

# Invalid word
if grep -q "No Definitions Found" <<< "$query"; then
  notify-send -u critical -t 3000 "Invalid word"
  exit 0
fi

# First 3 definitions
definitions=$(echo "$query" | jq -r '
  [.[0].meanings[]
   | {pos: .partOfSpeech, def: .definitions[0].definition}]
  | .[:3]
  | map("\(.pos): \(.def)")
  | join("\n\n")
')

# Notification
notify-send -t 60000 "$word" "$definitions"
