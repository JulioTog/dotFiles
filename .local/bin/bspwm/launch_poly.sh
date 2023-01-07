#!/bin/sh
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c ~/.config/polybar/main.ini --reload main &
  done
else
  polybar --reload example &
fi
