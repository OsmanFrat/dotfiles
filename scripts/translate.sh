#!/usr/bin/env bash

# Priority:
# 1) argument
# 2) clipboard (Neovim yank)
# 3) primary selection (mouse select)
word="${1:-$(wl-paste 2>/dev/null || wl-paste -p 2>/dev/null)}"

# Empty or invalid input
if [[ -z "$word" || "$word" =~ [\/[:space:]] ]]; then
  notify-send -u critical -t 3000 "Invalid input"
  exit 0
fi

# API request (force IPv4, capture HTTP status)
response=$(curl -4 -sS --connect-timeout 5 --max-time 10 \
  -w "\n%{http_code}" \
  "https://api.dictionaryapi.dev/api/v2/entries/en_US/$word")

body=$(echo "$response" | sed '$d')
status=$(echo "$response" | tail -n1)

# Connection / HTTP error
if [[ "$status" != "200" || -z "$body" ]]; then
  notify-send -u critical -t 3000 "Connection error" "HTTP $status"
  exit 1
fi

# Invalid word
if grep -q "No Definitions Found" <<< "$body"; then
  notify-send -u critical -t 3000 "Invalid word"
  exit 0
fi

# ===== DEFINITIONS =====
definitions=$(echo "$body" | jq -r '
  [.[0].meanings[]
   | {pos: .partOfSpeech, def: .definitions[0].definition}]
  | .[:3]
  | map("\(.pos): \(.def)")
  | join("\n\n")
')

notify-send -t 6000 "$word" "$definitions"

# ===== AUDIO (fast start) =====
audio_url=$(echo "$body" | jq -r '
  .[0].phonetics[]
  | select(.audio != "")
  | .audio
' | head -n 1)

if [[ -n "$audio_url" && "$audio_url" != "null" ]]; then
  mpv \
    --no-video \
    --cache=no \
    --demuxer-max-bytes=64k \
    --demuxer-readahead-secs=0 \
    "$audio_url" >/dev/null 2>&1 &
fi

