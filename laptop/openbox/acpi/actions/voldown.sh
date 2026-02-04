#!/bin/bash

USER_ID=1000
USER_NAME=$(id -nu "$USER_ID")
export XDG_RUNTIME_DIR="/run/user/$USER_ID"

#sudo -u "$USER_NAME" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
VOLUME=$(
    sudo -u "$USER_NAME" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
    sudo -u "$USER_NAME" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" /usr/bin/pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'
)

sudo -u "$USER_NAME" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" notify-send --hint=int:transient:1 -h string:x-dunst-stack-tag:volume -t 1500 "volume: $VOLUME"
