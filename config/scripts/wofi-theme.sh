#!/bin/bash

(
    OPTIONS="catppuccin\ntransparent\nultradark"

    CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Select Theme:")
    
    case "$CHOICE" in
        catppuccin)
            ~/.config/scripts/switch-theme catppuccin
            ;;
        transparent)
            ~/.config/scripts/switch-theme transparent
            ;;
        ultradark)
            ~/.config/scripts/switch-theme ultradark
            ;;
        *)
            ;;
    esac
) &
