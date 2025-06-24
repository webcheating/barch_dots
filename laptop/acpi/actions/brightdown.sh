#!/bin/bash

USER_ID=1000
USER_NAME=$(id -nu "$USER_ID")
export XDG_RUNTIME_DIR="/run/user/$USER_ID"

brightnessctl set 5%-
BRIGHTNESS=$(brightnessctl | grep -oP '\(\K[0-9]+(?=%)')
sudo -u "$USER_NAME" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" notify-send --hint=int:transient:1 -h string:x-dunst-stack-tag:brightness -t 1500 "brightness: $BRIGHTNESS"
