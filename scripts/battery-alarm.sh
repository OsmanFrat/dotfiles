#!/bin/bash

battery_persent = upower -i $(upower -e | grep 'BAT') | grep percentage | awk '{print $2}' | tr -d '%'
