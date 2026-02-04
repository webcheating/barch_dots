#!/bin/bash

battery=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [[ $status == "Discharging" ]]; then
    icon="🔋"
elif [[ $status == "Charging" ]]; then
    icon="⚡"
else
    icon="🔌"
fi

# Цвет по уровню заряда (через Pango markup)
if (( battery > 80 )); then
    color="#00FF00"
elif (( battery > 40 )); then
    color="#FFFF00"
else
    color="#FF0000"
fi

echo "<span foreground=\"$color\">$icon $battery%</span>"

