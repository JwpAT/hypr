#!/bin/sh

echo "yay and sddm are not installed. Installing..."
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Prompt for installation type
echo "What type of installation do you want?"
echo "1) full installation (extra utilities)"
echo "2) minimal installation"
read -p "Enter the number of your choice: " choice

case $choice in
  1)
    echo "Installing full installation."
    yay -S --needed - < packages-full
    ;;
  2)
    echo "Installing minimal installation."
    yay -S --needed - < packages-min
    ;;
  *)
    echo "Invalid choice. Installing minimal installation."
    yay -S --needed - < packages-min
    ;;
esac

echo "Installing Catppuccin Mocha theme..."
mkdir ~/.themes
unzip ~/hypr/Catppuccin-Mocha-Standard-Blue-Dark.zip
cp -r ~/hypr/Catppuccin-Mocha-Standard-Blue-Dark ~/.themes/
echo "Catppuccin Mocha theme has been installed successfully."

# Prompt to install Open WebUI
echo "Would you like to install Open WebUI for running local LLMs?"
printf "Enter your choice: (y/n): "
read choice

if [ "$choice" = "y" ]; then
    echo "Installing Open WebUI..."
    chmod +x config/install/scripts/open-webui.sh
    ./config/install/scripts/open-webui.sh
elif [ "$choice" = "n" ]; then
    echo "Installation cancelled."
else
    echo "Invalid choice. Please enter y or n."
fi

systemctl enable sddm
systemctl enable bluetooth.service
systemctl start bluetooth.service

echo "Installing config files"
mv ~/hypr/config/spicetify/catppuccin ~/.config/spicetify/Themes/
cp -r ~/hypr/config/* ~/.config/

echo "Running Firefox setup..."
chmod +x ~/.config/install/scripts/firefox.sh
~/.config/install/scripts/firefox.sh

chmod +x ~/.config/scripts/hyprlock-greeter.sh  
chmod +x ~/.config/scripts/wireless-menu.sh
sudo cp -r ~/.config/wlogout/icons/ /usr/share/wlogout/

echo "-----------------------------------------------------------------------------------------------------------"

chmod +x ~/.config/install/scripts/install-complete.sh
~/.config/install/scripts/install-complete.sh
