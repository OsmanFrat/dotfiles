#!/usr/bin/env bash

# Priority:
# 1) argument
# 2) clipboard (Neovim)
# 3) primary selection
text="${1:-$(wl-paste 2>/dev/null || wl-paste -p 2>/dev/null)}"

[[ -z "$text" ]] && notify-send -u critical "Çeviri" "Metin yok" && exit 0

# LibreTranslate instances (sırayla denenir)
APIS=(
  "https://libretranslate.de/translate"
  "https://translate.terraprint.co/translate"
  "https://libretranslate.com/translate"
)

translate() {
  curl -4 -sS --connect-timeout 5 --max-time 10 \
    -X POST "$1" \
    -H "Content-Type: application/json" \
    -d "{
          \"q\": \"$text\",
          \"source\": \"en\",
          \"target\": \"tr\",
          \"format\": \"text\"
        }" 2>/dev/null
}

for api in "${APIS[@]}"; do
  response=$(translate "$api")
  translation=$(echo "$response" | jq -r '.translatedText' 2>/dev/null)

  if [[ -n "$translation" && "$translation" != "null" ]]; then
    notify-send -t 60000 "EN → TR" "$translation"
    exit 0
  fi
done

notify-send -u critical -t 4000 "Çeviri" "Tüm servisler yanıt vermedi"
exit 1

