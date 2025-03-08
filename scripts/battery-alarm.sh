#!/bin/bash

# Batarya yüzdesini al
battery_percent=$(upower -i $(upower -e | grep 'BAT') | grep percentage | awk '{print $2}' | tr -d '%')

# Şarj durumu al (charging/discharging)
charging_status=$(upower -i $(upower -e | grep 'BAT') | grep state | awk '{print $2}')

# Eğer şarj olmuyorsa ve batarya %20 veya daha azsa alarm çal
if [ "$charging_status" != "charging" ] && [ "$battery_percent" -le 20 ]; then
  notify-send -u critical "Low battery! $battery_percent %"
  nohup mpv ./2.m4a > /dev/null 2>&1 &

fi

