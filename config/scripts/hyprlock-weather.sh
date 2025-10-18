#!/bin/bash

UNITS="imperial"
SYMBOL="°F"; [ "$UNITS" = "metric" ] && SYMBOL="°C"
API_URL="https://api.open-meteo.com/v1/forecast"

# get loc
loc=$(curl -sf "https://free.freeipapi.com/api/json")
lat=$(echo "$loc" | jq -r '.latitude')
lon=$(echo "$loc" | jq -r '.longitude')

weather=$(curl -sf "$API_URL?latitude=$lat&longitude=$lon&current=temperature_2m,weather_code,is_day&temperature_unit=$( [ "$UNITS" = "metric" ] && echo "celsius" || echo "fahrenheit" )&timezone=auto")

# batt info
battery_path="/sys/class/power_supply/BAT0"
battery_percent=$(cat "$battery_path/capacity" 2>/dev/null)
battery_status=$(cat "$battery_path/status" 2>/dev/null)

# batt icon
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

# display
if [ -n "$weather" ] && echo "$weather" | jq -e '.current' >/dev/null 2>&1; then
    temp=$(echo "$weather" | jq '.current.temperature_2m' | cut -d. -f1)
    code=$(echo "$weather" | jq '.current.weather_code')
    is_day=$(echo "$weather" | jq '.current.is_day')

    case $code in
        0)
            if [ "$is_day" -eq 1 ]; then
                icon="☀️"
            else
                icon="🌙"
            fi
            ;;
        1|2|3) icon="⛅" ;;
        45|48) icon="🌫️" ;;
        51|53|55|61|63|65|80|81|82) icon="🌧️" ;;
        56|57|66|67) icon="🌦️" ;;
        71|73|75|77|85|86) icon="❄️" ;;
        95|96|99) icon="⛈️" ;;
        *) icon="🌈" ;;
    esac

    echo "$icon $temp$SYMBOL • $battery_icon"
else
    echo "$battery_icon"
fi
