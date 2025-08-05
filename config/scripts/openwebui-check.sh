#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    # Show Zenity dialog with custom GTK theme
    choice=$(GTK_THEME=Catppuccin-Mocha-Standard-Blue-Dark zenity --question \
        --title="Docker Not Found" \
        --text="Docker is not installed. Do you want to attempt setup?" \
        --ok-label="Install" \
        --cancel-label="Cancel")

    # If user chose "Install"
    if [ $? -eq 0 ]; then
        chmod +x ~/.config/scripts/open-webui.sh
        ~/.config/install/scripts/open-webui.sh
    else
        # User clicked Cancel
        exit 1
    fi
else
    # Docker is installed, run Firefox with specified profile
    firefox -P ai --new-window http://localhost:8080/
fi
