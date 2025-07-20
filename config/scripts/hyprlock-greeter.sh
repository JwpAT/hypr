#!/bin/bash

# Check if any MPRIS media player (like Spotify) is running & playing
playing=$(playerctl --player=spotify status 2>/dev/null)

if [ "$playing" = "Playing" ]; then
    song=$(playerctl --player=spotify metadata title)
    artist=$(playerctl --player=spotify metadata artist)
    echo "   $artist — $song"
else
    hour=$(date +"%H")
    if [ "$hour" -ge 5 ] && [ "$hour" -lt 12 ]; then
      echo "Good morning, $USER"
    elif [ "$hour" -ge 12 ] && [ "$hour" -lt 17 ]; then
      echo "Good afternoon, $USER"
    else
      echo "Good evening, $USER"
    fi
fi
