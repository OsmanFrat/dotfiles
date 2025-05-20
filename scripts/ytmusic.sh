#!/bin/bash

# CTRL+C'yi yakala ve scripti sonlandır
trap 'echo "Çıkış yapılıyor..."; exit 0' INT TERM

yt-dlp --flat-playlist --get-url "https://www.youtube.com/playlist?list=PLTRI6HjSnitdTcJaf_2g7Ssi1OcsaMwxZ" > /home/ozu/dotfiles/scripts/playlist.txt

while true; do
  video_url=$(shuf -n 1 /home/ozu/dotfiles/scripts/playlist.txt)
  echo "Playing: $video_url"
  mpv --no-video --ytdl-format="bestaudio" "$video_url"
done
