#/usr/bin/bash

WEATHER_LOG="/home/$(whoami)/.cache/weather/weather.log"

echo "Tsukuba " > $WEATHER_LOG
curl wttr.in/Tsukuba?format=1 | tr -d '\n ' >> $WEATHER_LOG 
echo " / Unga " >> $WEATHER_LOG
curl wttr.in/Unga.Station?format=1 | tr -d '\n ' >> $WEATHER_LOG 
