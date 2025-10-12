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

# --- BATTERY INFO ---
battery_path="/sys/class/power_supply/BAT0"
battery_percent=$(cat "$battery_path/capacity" 2>/dev/null)
battery_status=$(cat "$battery_path/status" 2>/dev/null)

# --- BATTERY ICON / COLOR ---
if [[ "$battery_status" == "Charging" ]]; then
    battery_icon="<span color='#85eb81'>${battery_percent}% &#160;</span>"
else
    if [ "$battery_percent" -le 25 ]; then
        battery_icon="${battery_percent}% &#160;"
    elif [ "$battery_percent" -le 50 ]; then
        battery_icon="${battery_percent}% &#160;"
    elif [ "$battery_percent" -le 75 ]; then
        battery_icon="${battery_percent}% &#160;"
    else
        battery_icon="${battery_percent}% &#160;"
    fi
fi

# --- PARSE WEATHER + PRINT ---
if [ -n "$weather" ] && ! echo "$weather" | jq -e '.cod=="401"' >/dev/null; then
    temp=$(echo "$weather" | jq '.main.temp' | cut -d. -f1)
    condition=$(echo "$weather" | jq -r '.weather[0].main')
    icon_code=$(echo "$weather" | jq -r '.weather[0].icon')

    case $condition in
        Clear)
            if [[ $icon_code == *"n" ]]; then
                icon="🌙"
            else
                icon="☀️"
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

    echo "$icon $temp$SYMBOL • $battery_icon"
else
    echo "$battery_icon"
fi
