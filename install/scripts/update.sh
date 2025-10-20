#!/bin/bash

set -e

echo ">>> WARNING: UPDATING WILL RESET ALL MODIFIED CONFIGURATIONS."
read -rp ">>> Would you like to continue? (y/n): " choice

case "$choice" in
  y|Y|yes|YES)
    echo ">>> Proceeding with update..."
    ;;
  n|N|no|NO)
    echo ">>> Update cancelled."
    exit 0
    ;;
  *)
    echo ">>> Invalid choice. Please enter y or n."
    exit 1
    ;;
esac

echo ">>> Fetching fresh Hyprland config from GitHub..."
rm -rf ~/hypr
git clone https://github.com/jwpat/hypr.git ~/hypr

echo ">>> Updating packages from list..."
yay -Syu --needed - < ~/hypr/packages

echo ">>> Re-installing themes..."
mkdir -p ~/.themes
unzip -o ~/hypr/Catppuccin-Mocha-Standard-Blue-Dark.zip -d ~/hypr
cp -r ~/hypr/Catppuccin-Mocha-Standard-Blue-Dark ~/.themes/

echo ">>> Syncing configs..."
cp -r ~/hypr/config/* ~/.config/

echo ">>> Installing application .desktop entries..."
cp -r ~/hypr/install/applications ~/.local/share/

# Ensure scripts are executable
chmod +x ~/.config/scripts/*

echo ">>> Refreshing wallpapers..."
mkdir -p ~/.config/wallpapers/{transparent,catppuccin,ultradark}
unzip -o ~/.config/wallpapers/transparent.zip -d ~/.config/wallpapers/
unzip -o ~/.config/wallpapers/catppuccin.zip -d ~/.config/wallpapers/
unzip -o ~/.config/wallpapers/ultradark.zip -d ~/.config/wallpapers/

echo ">>> Update complete. Reload Hyprland to apply changes."

