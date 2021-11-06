#!/usr/bin/bash

while true
do
  echo "Playing: " > /home/n/.cache/spotify/spotify.log
  /home/n/.local/bin/spotifycli --statusshort >> /home/n/.cache/spotify/spotify.log 2>> /home/n/.cache/spotify/spotify.log
  if test "$(echo $(cat /home/n/.cache/spotify/spotify.log) | awk '{print $2 $3 $4}')" = "Spotifyisoff" ; then
    echo "no music"
    echo "No Music" > /home/n/.cache/spotify/spotify.log
  fi
  sleep 10
done

