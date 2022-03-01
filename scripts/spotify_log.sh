#!/usr/bin/bash

echo "Playing: " > /home/n/.cache/spotify/spotify.log
/home/n/.local/bin/spotifycli --statusshort >> /home/n/.cache/spotify/spotify.log 2>> /home/n/.cache/spotify/spotify.log
