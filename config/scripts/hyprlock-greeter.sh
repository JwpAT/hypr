#!/bin/bash

if playerctl --player=spotify,ncspot status 2>/dev/null | grep -q "Playing"; then
    song=$(playerctl --player=spotify,ncspot metadata title 2>/dev/null)
    artist=$(playerctl --player=spotify,ncspot metadata artist 2>/dev/null)
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
