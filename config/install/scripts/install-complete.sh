#!/bin/bash

echo -e "\033[1;36m"
cat << 'EOF'
  _____           _        _ _    _____                      _      _       
 |_   _|         | |      | | |  / ____|                    | |    | |      
   | |  _ __  ___| |_ __ _| | | | |     ___  _ __ ___  _ __ | | ___| |_ ___ 
   | | | '_ \/ __| __/ _` | | | | |    / _ \| '_ ` _ \| '_ \| |/ _ \ __/ _ \
  _| |_| | | \__ \ || (_| | | | | |___| (_) | | | | | | |_) | |  __/ ||  __/
 |_____|_| |_|___/\__\__,_|_|_|  \_____\___/|_| |_| |_| .__/|_|\___|\__\___|
                                                      | |                   
                                                      |_|                   
EOF
echo -e "\033[0m"

chars="////////////////////////////////////////////////////////////////////////////////"
colors=(31 33 32 36 34 35) # red, yellow, green, cyan, blue, magenta

for ((i=0; i<${#chars}; i++)); do
    color=${colors[i % ${#colors[@]}]}
    printf "\033[1;%sm%s" "$color" "${chars:$i:1}"
done

echo -e "\033[0m"  # Reset color at the end

if command -v spicetify >/dev/null 2>&1; then
  echo "Installation has completed! Please reboot your system. To install the Catppuccin Mocha theme for Spotify/Spicetify, locate ~/.config/scripts/spicetify.sh and execute the script."
else
  echo "Installation has completed! Reboot your system."
fi