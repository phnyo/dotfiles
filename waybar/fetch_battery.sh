#!/bin/bash

echo \{ \"text\": \"bat:$(cat /sys/class/power_supply/BAT0/capacity)% $(cat /sys/class/power_supply/BAT0/status | grep -q "Charging" && echo chr || echo disc)\", \"tooltip\": \"\", \"class\": \"\" \}
