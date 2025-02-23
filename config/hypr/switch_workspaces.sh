#!/bin/sh

# Geçerli çalışma alanını al
current=$(hyprctl activeworkspace -j | jq .id)

# Sadece pozitif id'li çalışma alanlarını say
total=$(hyprctl workspaces -j | jq '[.[] | select(.id > 0)] | length')

# Eğer current toplam workspace sayısından küçükse bir artır
if [ "$current" -lt "$total" ]; then
    hyprctl dispatch workspace $(($current + 1))
else
    hyprctl dispatch workspace 1
fi

