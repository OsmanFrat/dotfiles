#!/bin/bash

battery_percent=$(upower -i $(upower -e | grep 'BAT') | grep percentage | awk '{print $2}' | tr -d '%')

charging_status=$(upower -i $(upower -e | grep 'BAT') | grep state | awk '{print $2}')

if [ "$charging_status" != "charging" ] && [ "$battery_percent" -le 20 ]; then
  notify-send -u critical "Low battery! $battery_percent %"
  # mpv /home/ozu/dotfiles/scripts/2.m4a
fi

