#!/bin/bash

# Keys
API_KEY="84db87b07e392c4cb5d9cd4ee8978f6d"   # OpenWeatherMap
IPINFO_TOKEN="dd436c97055f22"                # ipinfo.io token

CITY=""   # leave blank for auto location
UNITS="imperial"  # metric or imperial
SYMBOL="°F"; [ "$UNITS" = "metric" ] && SYMBOL="°C"

API_URL="https://api.openweathermap.org/data/2.5/weather"

# Get location (lat,lon if CITY not set)
if [ -n "$CITY" ]; then
    query="q=$CITY"
else
    loc=$(curl -sf "https://ipinfo.io/json?token=$IPINFO_TOKEN" | jq -r '.loc')
    IFS=, read -r lat lon <<<"$loc"
    query="lat=$lat&lon=$lon"
fi

# Fetch weather
weather=$(curl -sf "$API_URL?$query&appid=$API_KEY&units=$UNITS")

# Get battery info
battery_percent=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

# Determine battery icon and format
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

# Parse & print weather + battery
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