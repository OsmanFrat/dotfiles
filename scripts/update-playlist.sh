#!/bin/bash

PLAYLIST_URL="https://www.youtube.com/playlist?list=PLTRI6HjSnitdTcJaf_2g7Ssi1OcsaMwxZ"
ARCHIVE_FILE="$HOME/dotfiles/scripts/downloaded.txt"
OUTPUT_DIR="$HOME/Music"

# Geçici dosya: mevcut oynatma listesindeki video ID'leri
TMP_PLAYLIST_IDS=$(mktemp)

# Oynatma listesindeki ID’leri çek
yt-dlp --flat-playlist -J "$PLAYLIST_URL" | jq -r '.entries[].id' | sed 's/^/youtube /' > "$TMP_PLAYLIST_IDS"

if [ ! -s "$ARCHIVE_FILE" ]; then
  echo "Archive file not found or empty. Downloading all songs..."

  # downloaded.txt dosyasını oluştur
  cp "$TMP_PLAYLIST_IDS" "$ARCHIVE_FILE"

  # Tüm şarkıları indir
  yt-dlp -x --audio-format opus --audio-quality 0 \
    --embed-thumbnail --embed-metadata \
    --download-archive "$ARCHIVE_FILE" \
    -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
    "$PLAYLIST_URL"

else
  # downloaded.txt ile oynatma listesi ID'leri karşılaştır
  if cmp -s "$ARCHIVE_FILE" "$TMP_PLAYLIST_IDS"; then
    echo "Playlist is up to date. No new songs to download."
  else
    echo "New songs found. Downloading missing tracks..."

    # downloaded.txt dosyasını güncelle
    cp "$TMP_PLAYLIST_IDS" "$ARCHIVE_FILE"

    # Eksik şarkıları indir
    yt-dlp -x --audio-format opus --audio-quality 0 \
      --embed-thumbnail --embed-metadata \
      --download-archive "$ARCHIVE_FILE" \
      -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
      "$PLAYLIST_URL"
  fi
fi

rm "$TMP_PLAYLIST_IDS"

