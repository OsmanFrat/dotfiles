#!/usr/bin/env bash

# Priority:
# 1) argument
# 2) clipboard (Neovim yank)
# 3) primary selection
text="${1:-$(wl-paste 2>/dev/null || wl-paste -p 2>/dev/null)}"

# Empty input
if [[ -z "$text" ]]; then
  notify-send -u critical -t 3000 "Çeviri" "Metin bulunamadı"
  exit 0
fi

# Translate EN -> TR
response=$(curl -sS --connect-timeout 5 --max-time 10 \
  -X POST "https://libretranslate.com/translate" \
  -H "Content-Type: application/json" \
  -d "{
        \"q\": \"$text\",
        \"source\": \"en\",
        \"target\": \"tr\",
        \"format\": \"text\"
      }")

translation=$(echo "$response" | jq -r '.translatedText')

if [[ -z "$translation" || "$translation" == "null" ]]; then
  notify-send -u critical -t 3000 "Çeviri" "Çeviri başarısız"
  exit 1
fi

notify-send -t 60000 "EN → TR" "$translation"

