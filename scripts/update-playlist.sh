#!/bin/bash

# Variables
PLAYLIST_URL="https://www.youtube.com/playlist?list=PLTRI6HjSnitdTcJaf_2g7Ssi1OcsaMwxZ"
ARCHIVE_FILE="$HOME/dotfiles/scripts/downloaded.txt"
OUTPUT_DIR="$HOME/Music"

# Check if downloaded.txt exists and is not empty
if [ ! -s "$ARCHIVE_FILE" ]; then
  echo "Archive file not found or empty. Downloading all songs..."

  # Fetch all video IDs and write them to downloaded.txt (for archive)
  yt-dlp --flat-playlist -J "$PLAYLIST_URL" \
    | jq -r '.entries[].id' \
    | sed 's/^/youtube /' > "$ARCHIVE_FILE"

  # Download all songs
  yt-dlp -x --audio-format opus --audio-quality 0 \
    --embed-thumbnail --embed-metadata \
    --download-archive "$ARCHIVE_FILE" \
    -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
    "$PLAYLIST_URL"

else
  echo "Archive file exists, downloading only new songs..."

  # Download only new songs
  yt-dlp -x --audio-format opus --audio-quality 0 \
    --embed-thumbnail --embed-metadata \
    --download-archive "$ARCHIVE_FILE" \
    -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
    "$PLAYLIST_URL"
fi

