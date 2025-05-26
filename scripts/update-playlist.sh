#!/bin/bash

# Değişkenler
PLAYLIST_URL="https://www.youtube.com/playlist?list=PLTRI6HjSnitdTcJaf_2g7Ssi1OcsaMwxZ"
ARCHIVE_FILE="$HOME/dotfiles/scripts/downloaded.txt"
OUTPUT_DIR="$HOME/Music"

# downloaded.txt var mı ve boş mu kontrol et
if [ ! -s "$ARCHIVE_FILE" ]; then
  echo "Arşiv dosyası bulunamadı veya boş. Tüm şarkılar indirilecek..."

  # Tüm şarkıların ID'lerini çekip downloaded.txt'ye yaz (arşiv için)
  yt-dlp --flat-playlist -J "$PLAYLIST_URL" \
    | jq -r '.entries[].id' \
    | sed 's/^/youtube /' > "$ARCHIVE_FILE"

  # Tüm şarkıları indir
  yt-dlp -x --audio-format opus --audio-quality 0 \
    --embed-thumbnail --embed-metadata \
    --download-archive "$ARCHIVE_FILE" \
    -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
    "$PLAYLIST_URL"

else
  echo "Arşiv dosyası var, sadece yeni şarkılar indirilecek..."

  # Sadece yeni şarkıları indir
  yt-dlp -x --audio-format opus --audio-quality 0 \
    --embed-thumbnail --embed-metadata \
    --download-archive "$ARCHIVE_FILE" \
    -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
    "$PLAYLIST_URL"
fi
