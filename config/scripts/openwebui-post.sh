#!/bin/bash

if ! command -v docker &> /dev/null; then
    choice=$(GTK_THEME=Catppuccin-Mocha-Standard-Blue-Dark zenity --question \
        --title="Docker Not Found" \
        --text="Docker is not installed. Do you want to attempt setup?" \
        --ok-label="Install" \
        --cancel-label="Cancel")

    if [ $? -eq 0 ]; then
        chmod +x ~/.config/scripts/openwebui-postinstall.sh
        kitty -e ~/.config/scripts/openwebui-postinstall.sh
    else
        exit 1
    fi
else
    firefox -P ai --new-window http://localhost:8080/
fi
