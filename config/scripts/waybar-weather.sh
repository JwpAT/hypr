#!/bin/bash

# --- CONFIG ---
API_KEY="84db87b07e392c4cb5d9cd4ee8978f6d"   # OpenWeatherMap
CITY=""                                       # leave blank for auto location
UNITS="imperial"                              # "metric" or "imperial"
SYMBOL="°F"; [ "$UNITS" = "metric" ] && SYMBOL="°C"
API_URL="https://api.openweathermap.org/data/2.5/weather"

# --- GET LOCATION (lat/lon if CITY not set) ---
if [ -n "$CITY" ]; then
    query="q=$CITY"
else
    # Use FreeIPAPI (fast, no key required, ~60 req/min)
    loc=$(curl -sf "https://freeipapi.com/api/json")
    lat=$(echo "$loc" | jq -r '.latitude')
    lon=$(echo "$loc" | jq -r '.longitude')

    # fallback if null or error
    if [ -z "$lat" ] || [ "$lat" = "null" ]; then
        echo "FreeIPAPI failed, using cached or default location" >&2
        lat="40.7128"  # fallback (NYC)
        lon="-74.0060"
    fi

    query="lat=$lat&lon=$lon"
fi

# --- FETCH WEATHER ---
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

    echo "$temp$SYMBOL $icon"
else
    echo "Weather Unavailable"
fi
