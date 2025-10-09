#!/bin/bash

# Key
API_KEY="84db87b07e392c4cb5d9cd4ee8978f6d"   # OpenWeatherMap

CITY=""   # leave blank for auto location
UNITS="imperial"  # metric or imperial
SYMBOL="°F"; [ "$UNITS" = "metric" ] && SYMBOL="°C"

API_URL="https://api.openweathermap.org/data/2.5/weather"

# Get location (lat,lon if CITY not set)
if [ -n "$CITY" ]; then
    query="q=$CITY"
else
    # add ?token=YOURTOKEN to avoid rate limiting
    loc=$(curl -sf "https://ipinfo.io/json" | jq -r '.loc')
    IFS=, read -r lat lon <<<"$loc"
    query="lat=$lat&lon=$lon"
fi

# Fetch weather
weather=$(curl -sf "$API_URL?$query&appid=$API_KEY&units=$UNITS")

# Parse & print
if [ -n "$weather" ] && ! echo "$weather" | jq -e '.cod=="401"' >/dev/null; then
    temp=$(echo "$weather" | jq '.main.temp' | cut -d. -f1)
    condition=$(echo "$weather" | jq -r '.weather[0].main')
    icon_code=$(echo "$weather" | jq -r '.weather[0].icon') # e.g. "01n", "01d"

    case $condition in
        Clear)
            if [[ $icon_code == *"n" ]]; then
                icon="🌙"  # night clear
            else
                icon="☀️"  # day clear
            fi
            ;;
        Clouds) icon="☁️" ;;
        Rain) icon="🌧️" ;;
        Drizzle) icon="🌦️" ;;
        Thunderstorm) icon="⛈️" ;;
        Snow) icon="❄️" ;;
        Mist|Fog|Haze|Smoke) icon="🌫️" ;;
        *) icon="🌈" ;;
    esac

    echo "$icon $temp$SYMBOL"
else
    echo "Weather unavailable"
fi
