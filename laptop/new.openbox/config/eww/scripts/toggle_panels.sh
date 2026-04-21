#!/bin/bash
# toggle_panels.sh — вызывается только с Super_L биндом
# Логика:
#   - Если хоть одно окно открыто → закрыть все открытые (без открытия новых)
#   - Если оба закрыты → открыть оба

LOCKFILE="/tmp/eww_toggle_panels.lock"
DASHBOARD="performance_monitor"
CC="control_center_window"

(
  flock -n 9 || exit 1  # если уже выполняется — пропустить

  dash_open=false
  cc_open=false

  active=$(eww active-windows 2>/dev/null)

  echo "$active" | grep -q "$DASHBOARD" && dash_open=true
  echo "$active" | grep -q "$CC"        && cc_open=true

  if $dash_open || $cc_open; then
    # Закрываем только то, что реально открыто
    if $dash_open; then
      eww update performance_monitor_visible=false
      eww close "$DASHBOARD"
    fi
    if $cc_open; then
      eww update control_center_visible=false
      eww close "$CC"
    fi
  else
    # Оба закрыты — открываем оба
    eww update performance_monitor_visible=true
    eww open "$DASHBOARD"
    eww update control_center_visible=true
    eww open "$CC"
  fi

) 9>"$LOCKFILE"
