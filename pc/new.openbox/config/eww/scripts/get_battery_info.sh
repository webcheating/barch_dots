#!/usr/bin/env bash

## Dependencies: acpi, upower

# Get battery percentage
get_bat_perc() {
	acpi -b | cut -d',' -f2 | tr -d ' %'
}

# Get battery status
get_bat_stat() {
	acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '
}

# Get icon
get_icon() {
	BAT_PREC=$(get_bat_perc)
	BAT_STAT=$(get_bat_stat)

	if [[ "$BAT_STAT" == *"Full"* ]]; then
		icon=""
	elif [[ "$BAT_STAT" == *"Charging"* ]]; then
		icon=""
	else
		if (( BAT_PREC <= 20 )); then
			icon=""
		elif (( BAT_PREC <= 40 )); then
			icon=""
		elif (( BAT_PREC <= 60 )); then
			icon=""
		elif (( BAT_PREC <= 80 )); then
			icon=""
		else
			icon=""
		fi
	fi
}

# Main
battery_info=$(upower -i "$(upower -e | grep BAT | head -n1)")

PERCENTAGE=$(echo "$battery_info" | awk '/percentage:/ {print $2}' | tr -d '%')
STATE=$(echo "$battery_info" | awk '/state:/ {print $2}')
TIME=$(echo "$battery_info" | awk '/time to empty|time to full/ {print $4, $5}')

get_icon

# JSON output (same style as your second script)
#printf '{"battery_name": "%s", "profile": "%s"}\n' "$PERCENTAGE" "$STATE"
printf '{'
printf '"percentage": "%s", ' "$PERCENTAGE"
printf '"state": "%s", ' "$STATE"
printf '"time": "%s", ' "$TIME"
printf '"icon": "%s"' "$icon"
printf '}\n'
