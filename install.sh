#!/bin/sh

chmod +x ~/hypr/install/scripts/pretty-greeter-1.sh
~/hypr/install/scripts/pretty-greeter-1.sh

echo "yay and sddm are not installed. Installing..."
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Installation Type ------------------------------------------------------------------------------------

chmod +x ~/hypr/install/scripts/pretty-greeter-2.sh
~/hypr/install/scripts/pretty-greeter-2.sh

echo "Select installation type:"
echo "1) Full installation"
echo "2) Minimal installation"
read -r choice

case $choice in
  1)
    echo "Installing full installation."
    yay -S --needed - < ~/hypr/packages-full
    ;;
  2)
    echo "Installing minimal installation."
    yay -S --needed - < ~/hypr/packages-min
    ;;
  *)
    echo "Invalid choice. Installing minimal installation."
    yay -S --needed - < ~/hypr/packages-min
    ;;
esac

# Theme Installation ------------------------------------------------------------------------------------

echo "Installing Catppuccin Mocha theme..."
mkdir -p ~/.themes
unzip ~/hypr/Catppuccin-Mocha-Standard-Blue-Dark.zip
cp -r ~/Catppuccin-Mocha-Standard-Blue-Dark ~/.themes/
echo "Catppuccin Mocha theme has been installed successfully."

# Prompt to install Open WebUI ---------------------------------------------------------------------------

chmod +x ~/hypr/install/scripts/pretty-greeter-3.sh
~/hypr/install/scripts/pretty-greeter-3.sh

echo "Would you like to install Open WebUI for running local LLMs?"
printf "Enter your choice: (y/n): "
read -r choice

case $choice in
  y|Y)
    echo "Installing Open WebUI..."
    chmod +x ~/hypr/install/scripts/open-webui.sh
    ~/hypr/install/scripts/open-webui.sh
    ;;
  n|N)
    echo "Open WebUI Installation cancelled."
    ;;
  *)
    echo "Invalid choice. Please enter y or n."
    ;;
esac

cp -r /hypr/install/applications ~/.local/share/
chmod +x ~/.local/share/applications/openwebui.desktop ~/.local/share/applications/chatgpt.desktop

# Enable Services -----------------------------------------------------------------------------------------

chmod +x ~/hypr/install/scripts/pretty-greeter-4.sh
~/hypr/install/scripts/pretty-greeter-4.sh

sudo systemctl enable sddm bluetooth.service
sudo systemctl start bluetooth.service

# Config ---------------------------------------------------------------------------------------------------

echo "Installing config files"
mv ~/hypr/config/spicetify/catppuccin ~/.config/spicetify/Themes/

echo "Running Firefox setup..."
chmod +x ~/hypr/install/scripts/firefox.sh
~/hypr/install/scripts/firefox.sh

cp -r ~/hypr/config/* ~/.config/
chmod +x ~/.config/scripts/hyprlock-greeter.sh ~/.config/scripts/wireless-menu.sh ~/.config/scripts/waybar-weather.sh
sudo cp -r ~/.config/wlogout/icons/ /usr/share/wlogout/

chmod +x ~/hypr/install/scripts/install-complete.sh
~/hypr/install/scripts/install-complete.sh
