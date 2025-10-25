#!/bin/bash

UNITS="imperial"
SYMBOL="°F"; [ "$UNITS" = "metric" ] && SYMBOL="°C"
API_URL="https://api.open-meteo.com/v1/forecast"

# get loc
loc=$(curl -sf "https://ifconfig.co/json")
lat=$(echo "$loc" | jq -r '.latitude')
lon=$(echo "$loc" | jq -r '.longitude')

# fallback
if [ -z "$lat" ] || [ "$lat" = "null" ]; then
    loc=$(curl -sf "https://ipinfo.io/json")
    if [ -n "$loc" ]; then
        coords=$(echo "$loc" | jq -r '.loc')
        lat=$(echo "$coords" | cut -d',' -f1)
        lon=$(echo "$coords" | cut -d',' -f2)
    fi
fi
weather=$(curl -sf "$API_URL?latitude=$lat&longitude=$lon&current=temperature_2m,weather_code,is_day&temperature_unit=$( [ "$UNITS" = "metric" ] && echo "celsius" || echo "fahrenheit" )&timezone=auto")

# display
if [ -n "$weather" ] && echo "$weather" | jq -e '.current' >/dev/null 2>&1; then
    temp=$(echo "$weather" | jq '.current.temperature_2m' | cut -d. -f1)
    code=$(echo "$weather" | jq '.current.weather_code')
    is_day=$(echo "$weather" | jq '.current.is_day')

    case $code in
        0)  [ "$is_day" -eq 1 ] && icon="☀️" || icon="🌙" ;;
        1|2|3) icon="⛅" ;;
        45|48) icon="🌫️" ;;
        51|53|55|61|63|65|80|81|82) icon="🌧️" ;;
        56|57|66|67) icon="🌦️" ;;
        71|73|75|77|85|86) icon="❄️" ;;
        95|96|99) icon="⛈️" ;;
        *) icon="🌈" ;;
    esac

    echo "$temp$SYMBOL $icon"
else
    echo "Weather Unavailable"
fi
