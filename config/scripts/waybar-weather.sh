#!/bin/bash

API_KEY="84db87b07e392c4cb5d9cd4ee8978f6d"
CITY="New York,US"
UNITS="imperial"
URL="https://api.openweathermap.org/data/2.5/weather?q=$(echo "$CITY" | sed 's/ /%20/g')&appid=${API_KEY}&units=${UNITS}"

weather=$(curl -sf "$URL")

if [ -n "$weather" ] && ! echo "$weather" | grep -q '"cod":401'; then
    temp=$(echo "$weather" | jq '.main.temp' | cut -d "." -f 1)
    condition=$(echo "$weather" | jq -r '.weather[0].main')

    case $condition in
        Clear) icon="☀️" ;;
        Clouds) icon="☁️" ;;
        Rain) icon="🌧️" ;;
        Drizzle) icon="🌦️" ;;
        Thunderstorm) icon="⛈️" ;;
        Snow) icon="❄️" ;;
        Mist|Fog|Haze) icon="☁️" ;;
        *) icon="🌈" ;;
    esac

    echo "$icon $temp°F"
else
    echo "Weather unavailable"
fi

