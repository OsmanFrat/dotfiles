#!/usr/bin/env bash

MAX_DEFS=6

# Priority:
# 1) argument
# 2) clipboard (Neovim)
# 3) primary selection
word="${1:-$(wl-paste 2>/dev/null || wl-paste -p 2>/dev/null)}"

if [[ -z "$word" || "$word" =~ [\/[:space:]] ]]; then
  notify-send -u critical -t 3000 "Invalid input"
  exit 0
fi

# ================== DICTIONARY ==================
response=$(curl -4 -sS --connect-timeout 5 --max-time 10 \
  -w "\n%{http_code}" \
  "https://api.dictionaryapi.dev/api/v2/entries/en_US/$word")

body=$(echo "$response" | sed '$d')
status=$(echo "$response" | tail -n1)

if [[ "$status" != "200" || -z "$body" ]]; then
  notify-send -u critical -t 3000 "Connection error" "HTTP $status"
  exit 1
fi

if grep -q "No Definitions Found" <<< "$body"; then
  notify-send -u critical -t 3000 "Invalid word"
  exit 0
fi

definitions=$(echo "$body" | jq -r "
  [.[0].meanings[]
   | {pos: .partOfSpeech, def: .definitions[0].definition}]
  | .[:$MAX_DEFS]
  | map(\"• \\(.pos): \\(.def)\")
  | join(\"\\n\\n\")
")

# ================== TRANSLATION (EN → TR) ==================
translation=$(curl -sS --connect-timeout 5 --max-time 10 \
  -X POST "https://libretranslate.com/translate" \
  -H "Content-Type: application/json" \
  -d "{
        \"q\": \"$word\",
        \"source\": \"en\",
        \"target\": \"tr\",
        \"format\": \"text\"
      }" | jq -r '.translatedText')

[[ -z "$translation" || "$translation" == "null" ]] && translation="(Türkçe çeviri yok)"

# ================== NOTIFICATION ==================
notify-send -t 60000 \
  "$word → $translation" \
  "$definitions"

# ================== AUDIO ==================
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
