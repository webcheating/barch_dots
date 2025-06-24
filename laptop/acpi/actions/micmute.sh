#!/bin/bash

USER_ID=1000
USER_NAME=$(id -nu "$USER_ID")
export XDG_RUNTIME_DIR="/run/user/$USER_ID"

sudo -u "$USER_NAME" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" /usr/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle
