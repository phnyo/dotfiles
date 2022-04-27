#!/usr/bin/bash

CURRENT_VAL=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
MAX_VAL=$(cat /sys/class/backlight/intel_backlight/max_brightness)

if [ $1 = '-' ]; then
  echo $(expr $CURRENT_VAL - $(expr $MAX_VAL / 20)) > /sys/class/backlight/intel_backlight/brightness
elif [ $1 = '+' ]; then
  echo $(expr $CURRENT_VAL + $(expr $MAX_VAL / 20)) > /sys/class/backlight/intel_backlight/brightness
fi

