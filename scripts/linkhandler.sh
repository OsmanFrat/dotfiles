
#!/bin/sh

# Feed script a URL or file location.
# If an image, it will view in feh.
# If a video or gif, it will view in mpv.
# If a music file, it will play in cmus.
# If a PDF or comic file, it will open in zathura.
# Otherwise, it opens the link in Firefox.

if [ -z "$1" ]; then
    url="$(wl-paste)"
else
    url="$1"
fi

case "$url" in
    *mkv*|*webm*|*mp4*|*youtube.com/watch*|*youtube.com/playlist*|*youtube.com/shorts*|*youtu.be*|*hooktube.com*|*bitchute.com*|*videos.lukesmith.xyz*|*odysee.com*)
        # Run yt-dlp in the background and suppress output
        setsid -f yt-dlp -f 'bestvideo[height<=720]+bestaudio/best' "$url" -o - | mpv - --force-seekable=yes >/dev/null 2>&1 & ;;
    *png*|*jpg*|*jpeg*|*gif*)
        curl -sL "$url" -o "/tmp/image" && feh "/tmp/image" >/dev/null 2>&1 & ;;
    *pdf*|*cbz*|*cbr*)
        curl -sL "$url" -o "/tmp/document" && zathura "/tmp/document" >/dev/null 2>&1 & ;;
    *mp3*|*flac*|*opus*|*mp3?source*)
        curl -sL "$url" -o "/tmp/audio" && cmus-remote -q "/tmp/audio" >/dev/null 2>&1 & ;;
    *)
        setsid -f firefox "$url" >/dev/null 2>&1 ;;
esac

