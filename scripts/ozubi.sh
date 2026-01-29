#!/usr/bin/env bash

copy=false
download=false

# -----------------------------
# Flag parsing
# -----------------------------
while getopts ":md" opt; do
  case "$opt" in
    m) copy=true ;;
    d) download=true ;;
  esac
done

shift $((OPTIND - 1))

query="$*"

if [[ -z "$query" ]]; then
  echo "Usage: $0 [-m] [-d] <query>"
  exit 1
fi

# -----------------------------
# Video category whitelist
# -----------------------------
VIDEO_CATEGORIES='["200","201","202","203","204","205","206","207","208","209","299"]'

# -----------------------------
# Search
# -----------------------------
json="$(piratebay -j search "$query")"

# -----------------------------
# Filter + sort
# -----------------------------
sorted="$(
  printf '%s' "$json" \
  | jq --argjson cats "$VIDEO_CATEGORIES" '
      [.[] | select(.category as $c | $cats | index($c))]
      | sort_by(.seeders)
      | reverse
    '
)"

# -----------------------------
# fzf input
# -----------------------------
fzf_input="$(
  printf '%s' "$sorted" \
  | jq -r '
      .[] |
      "\(.id)\t\(.seeders) seed\t[\(.category)]\t\(.name)"
    '
)"

# -----------------------------
# fzf selection
# -----------------------------
selected_line="$(
  printf '%s\n' "$fzf_input" \
  | fzf --delimiter='\t' --with-nth=2.. --prompt="Torrent seç: "
)"

[[ -z "$selected_line" ]] && exit 0

selected_id="$(cut -f1 <<< "$selected_line")"

# -----------------------------
# Magnet
# -----------------------------
secilen_torrent="$(
  piratebay -j info "$selected_id" | jq -r '.magnet'
)"

# -----------------------------
# -d → indir ve çık
# -----------------------------
if [ "$download" = true ]; then
  setsid qbittorrent "$secilen_torrent" >/dev/null 2>&1 &
  echo "⬇️  Torrent indirmeye eklendi"
  exit 0
fi

# -----------------------------
# -m → kopyala ve çık
# -----------------------------
if [ "$copy" = true ]; then
  printf '%s' "$secilen_torrent" | wl-copy
  echo "📋 Magnet link clipboard'a kopyalandı"
  exit 0
fi

# -----------------------------
# default output (hiç parametre yoksa)
# -----------------------------
if [ "$copy" = false ] && [ "$download" = false ]; then
  echo
  echo "Video mpv player ile aciliyor..."
  printf '%s' "$secilen_torrent" | wl-copy
  btplay -p mpv "$secilen_torrent"
fi

