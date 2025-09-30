#!/bin/bash
# ~/.config/scripts/wofi-theme.sh
# Fully detached for Hyprland keybindings

# Run everything in a subshell and detach
(
    # List of themes
    OPTIONS="catppuccin\ntransparent\nultradark"

    # Show Wofi menu and get selection
    CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Select Theme:")

    # Run the switch script based on selection
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
            # Do nothing if canceled
            ;;
    esac
) &
