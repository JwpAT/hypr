#!/bin/bash

# Icons
ICON_NORMAL=""   # Normal bell
ICON_SILENT=""   # DND on
ICON_WIFI=""
ICON_BT=""

STATUS=$(swaync-client -D 2>/dev/null)

# If swaync-client just returns "true" or "false"
if [[ "$STATUS" == "true" ]]; then
    echo " $ICON_SILENT  / $ICON_WIFI  / $ICON_BT"
    exit
elif [[ "$STATUS" == "false" ]]; then
    echo " $ICON_NORMAL  / $ICON_WIFI  / $ICON_BT"
    exit
fi