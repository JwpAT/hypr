#!/bin/bash
set -euo pipefail

# Cache file to store last screenshot path
cache="$HOME/.cache/last_screenshot"
dir="$HOME/Pictures"
mkdir -p "$dir"

case "${1:-notif}" in
  notif)
    # Close SwayNC control panel
    swaync-client --close-panel || true
    sleep 0.7

    # Take screenshot and save it
    file="$dir/$(date +'%Y%m%d_%Hh%Mm%Ss')_grim.png"
    grim -g "$(slurp -d)" "$file" || exit 1

    # Cache file path for later use
    echo "$file" > "$cache"

    # Send notification with an "Open" button
    notify-send -t 5000 "Screenshot saved!" \
        "Click to view." \
        --app-name="Screenshot" \
        --icon="$file" \
    ;;

  open)
    # Open the most recent screenshot (cached)
    if [[ -f "$cache" ]]; then
      file=$(<"$cache")
      nohup eog "$file" >/dev/null 2>&1 &
    else
      notify-send "Screenshot" "No screenshot found to open." --urgency=low
    fi
    ;;

  *)
    echo "Usage: $0 [notif|open]"
    exit 1
    ;;
esac
