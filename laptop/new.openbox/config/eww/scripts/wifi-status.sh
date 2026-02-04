#!/bin/bash
# ~/.config/eww/scripts/system-status.sh
# === WiFi Status ===
#wifi_interface="wlp3s0"
wifi_interface="wlan0"
wifi_state=$(cat /sys/class/net/$wifi_interface/operstate 2>/dev/null)
if [ "$wifi_state" = "up" ]; then
    # Get signal strength
    wifi_signal=$(nmcli -t -f SIGNAL dev wifi | head -n1 2>/dev/null)
    
    if [ -z "$wifi_signal" ] || ! [[ "$wifi_signal" =~ ^[0-9]+$ ]]; then
        wifi_signal=$(awk 'NR==3 {print int($3 * 100 / 70)}' /proc/net/wireless 2>/dev/null)
    fi
    
    if [ -z "$wifi_signal" ] || ! [[ "$wifi_signal" =~ ^[0-9]+$ ]]; then
        wifi_signal=100
    fi
    
    # Set icon based on signal strength
    if [ "$wifi_signal" -le 20 ]; then
        wifi_icon="󰤯"
    elif [ "$wifi_signal" -le 40 ]; then
        wifi_icon="󰤟"
    elif [ "$wifi_signal" -le 60 ]; then
        wifi_icon="󰤢"
    elif [ "$wifi_signal" -le 80 ]; then
        wifi_icon="󰤥"
    else
        wifi_icon="󰤨"
    fi
    
    # Calculate network speed
    rx_bytes_1=$(cat /sys/class/net/$wifi_interface/statistics/rx_bytes)
    tx_bytes_1=$(cat /sys/class/net/$wifi_interface/statistics/tx_bytes)
    
    sleep 1
    
    rx_bytes_2=$(cat /sys/class/net/$wifi_interface/statistics/rx_bytes)
    tx_bytes_2=$(cat /sys/class/net/$wifi_interface/statistics/tx_bytes)
    
    rx_rate=$((rx_bytes_2 - rx_bytes_1))
    tx_rate=$((tx_bytes_2 - tx_bytes_1))
    
    # Format speed
    format_speed() {
        local bytes=$1
        if [ $bytes -lt 1024 ]; then
            echo "${bytes}B/s"
        elif [ $bytes -lt 1048576 ]; then
            echo "$(awk "BEGIN {printf \"%.1f\", $bytes/1024}")K/s"
        else
            echo "$(awk "BEGIN {printf \"%.1f\", $bytes/1048576}")M/s"
        fi
    }
    
    downspeed=$(format_speed $rx_rate)
    upspeed=$(format_speed $tx_rate)
    
    wifi_display="$wifi_icon  ↓$downspeed ↑$upspeed"
else
    wifi_display="󰤮 Disconnected"
fi

# === Battery ===
## Dependencies: `acpi`

# Get battery percentage
get_bat_perc() {
	acpi -b | cut -d',' -f2 | tr -d ' ',\%
}

# Get battery status
get_bat_stat() {
	acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '
}

# Get icons
BAT_PREC=`get_bat_perc`
BAT_STAT=`get_bat_stat`

if [[ "$BAT_STAT" == *"Full"* ]]; then
	bat_icon=''
elif [[ "$BAT_STAT" == *"Charging"* ]]; then
	bat_icon=''
else
	if [[ ("$BAT_PREC" -ge "0") && ("$BAT_PREC" -le "20") ]]; then
		bat_icon=' '
	elif [[ ("$BAT_PREC" -ge "20") && ("$BAT_PREC" -le "40") ]]; then
		bat_icon=' '
	elif [[ ("$BAT_PREC" -ge "40") && ("$BAT_PREC" -le "60") ]]; then
		bat_icon=' '
	elif [[ ("$BAT_PREC" -ge "60") && ("$BAT_PREC" -le "80") ]]; then
		bat_icon=' '
	elif [[ ("$BAT_PREC" -ge "80") && ("$BAT_PREC" -le "100") ]]; then
		bat_icon=' '
	fi
fi

# Get status
battery_info=$(upower -i $(upower -e | grep BAT))
bat_capacity=$(echo "$battery_info" | awk '/percentage:/ {print $2}' | tr -d '%')
status=$(echo "$battery_info" | awk '/state:/ {print $2}')
time=$(echo "$battery_info" | awk '/time to empty|time to full/ {print $4, $5}')
#get_status
bat_display="$bat_icon ${bat_capacity}%"

# === Brightness ===
brightness=$(brightnessctl get 2>/dev/null)
max_brightness=$(brightnessctl max 2>/dev/null)

if [ -n "$brightness" ] && [ -n "$max_brightness" ] && [ "$max_brightness" -gt 0 ]; then
    bright_pct=$((brightness * 100 / max_brightness))
else
    bright_pct=0
fi
if [ "$bright_pct" -le 25 ]; then
    bright_icon="󰃞 "
elif [ "$bright_pct" -le 50 ]; then
    bright_icon="󰃝 "
elif [ "$bright_pct" -le 75 ]; then
    bright_icon="󰃟 "
else
    bright_icon="󰃠 "
fi

# === Volume ===
muted=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -o 'yes')
vol_pct=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -Po '\d+(?=%)' | head -1)
# Pastikan vol_pct tidak kosong
if [ -z "$vol_pct" ] || ! [[ "$vol_pct" =~ ^[0-9]+$ ]]; then
    vol_pct=0
fi
if [ "$muted" = "yes" ]; then
    vol_icon="󰖁"
else
    if [ "$vol_pct" -le 30 ]; then
        vol_icon=""
    elif [ "$vol_pct" -le 70 ]; then
        vol_icon=""
    else
        vol_icon=" "
    fi
fi

# === Output JSON format untuk EWW ===
cat << EOF
{
  "wifi": "$wifi_display",
  "battery": "$bat_display",
  "brightness": "$bright_icon",
  "volume": "$vol_icon"
}
EOF
