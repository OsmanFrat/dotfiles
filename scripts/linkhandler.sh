#!/bin/sh

# Güncellenmiş Link Handler Scripti (2024)
# Özellikler:
# - YouTube için optimize edilmiş yt-dlp ayarları (720p MP4 öncelikli)
# - Geçici dosyalar için /tmp yerine $XDG_CACHE_HOME kullanımı
# - Hata durumlarında fallback tarayıcı açma
# - Medya oynatıcılarda daha stabil davranış

url="${1:-$(wl-paste || xclip -o 2>/dev/null)}"  # Wayland veya X11 clipboard desteği

# Cache dizini oluştur
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/linkhandler"
mkdir -p "$cache_dir"

cleanup() {
    [ -f "$tmp_file" ] && rm -f "$tmp_file"
}
trap cleanup EXIT


play_media() {
    case "$1" in
        *youtube.com/watch*|*youtube.com/playlist*|*youtube.com/shorts*|*youtu.be*)
            mpv --ytdl=yes \
                --ytdl-format='bestvideo[height<=720][vcodec!=av01]+bestaudio/best[height<=720][vcodec!=av01]/best' \
                --cache=yes \
                --force-seekable=yes \
                --no-cache-pause \
                --input-ipc-server=/tmp/mpv-socket \
                "$url" || {
                    echo "YouTube oynatma başarısız, Firefox ile açılıyor..." >&2
                    setsid -f firefox "$url"
                }
            ;;
        *mkv|*webm|*mp4|*hooktube.com|*bitchute.com|*odysee.com)
            mpv --cache=yes "$url" || setsid -f firefox "$url"
            ;;
        *)
            return 1
            ;;
    esac
}

view_image() {
    tmp_file="${cache_dir}/image_$(date +%s).${url##*.}"
    if curl -sL "$url" -o "$tmp_file"; then
        feh --scale-down --auto-zoom "$tmp_file" &
    else
        setsid -f firefox "$url"
    fi
}

read_document() {
    tmp_file="${cache_dir}/doc_$(date +%s).${url##*.}"
    if curl -sL "$url" -o "$tmp_file"; then
        zathura "$tmp_file" &
    else
        setsid -f firefox "$url"
    fi
}

play_audio() {
    tmp_file="${cache_dir}/audio_$(date +%s).${url##*.}"
    if curl -sL "$url" -o "$tmp_file"; then
        pgrep cmus >/dev/null && cmus-remote -f "$tmp_file" || mpv "$tmp_file"
    else
        setsid -f firefox "$url"
    fi
}

case "$url" in
    *mkv*|*webm*|*mp4*|*youtube.com/watch*|*youtube.com/playlist*|*youtube.com/shorts*|*youtu.be*|*hooktube.com*|*bitchute.com*|*odysee.com*)
        play_media "$url" ;;
    *png*|*jpg*|*jpeg*|*gif*)
        view_image ;;
    *pdf*|*cbz*|*cbr*)
        read_document ;;
    *mp3*|*flac*|*opus*|*m4a*|*wav*)
        play_audio ;;
    *)
        setsid -f firefox "$url" >/dev/null 2>&1 ;;
esac
