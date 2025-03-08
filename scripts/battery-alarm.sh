#!/bin/bash

battery_persent=$(upower -i $(upower -e | grep 'BAT') | grep percentage | awk '{print $2}' | tr -d '%')

if [ "$battery_persent" -le 20 ]; then
  notify-send -u critical "Low battery! $battery_persent %"
  mpv ./2.m4a
fi

