#!/bin/bash

# Установите правильные переменные окружения
export DISPLAY=:0
export XAUTHORITY=/home/user0o1/.Xauthority

# Перезапуск sxhkd
pkill sxhkd
sxhkd &
