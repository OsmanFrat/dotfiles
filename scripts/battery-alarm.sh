#!/bin/bash

battery_persent = upower -i $(upower -e | grep 'BAT') | grep percentage | awk '{print $2}' | tr -d '%'

if [ $battery_persent <= 20 ]; then
  echo "ok"
fi
  echo "end"
