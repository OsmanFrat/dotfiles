#!/bin/bash

# Ortam değişkenlerini ayarla
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XDG_RUNTIME_DIR=/run/user/1000

# Batarya yüzdesini al
battery_percent=$(upower -i $(upower -e | grep 'BAT') | grep percentage | awk '{print $2}' | tr -d '%')

# Şarj durumu al (charging/discharging)
charging_status=$(upower -i $(upower -e | grep 'BAT') | grep state | awk '{print $2}')

# Eğer şarj olmuyorsa ve batarya %20 veya daha azsa alarm çal
if [ "$charging_status" != "charging" ] && [ "$battery_percent" -le 10 ]; then
  notify-send -u critical "Low battery! $battery_percent %"
  mpv /home/ozu/dotfiles/scripts/2.m4a
fi
