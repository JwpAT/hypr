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
unzip -o ~/hypr/Catppuccin-Mocha-Standard-Blue-Dark.zip -d ~/hypr
cp -r ~/hypr/Catppuccin-Mocha-Standard-Blue-Dark ~/.themes/
echo "Catppuccin Mocha theme has been installed successfully."

# Prompt to install Open WebUI ---------------------------------------------------------------------------

chmod +x ~/hypr/install/scripts/pretty-greeter-3.sh
~/hypr/install/scripts/pretty-greeter-3.sh

chmod +x ~/hypr/install/scripts/ai-config.sh
~/hypr/install/scripts/ai-config.sh

# Config ---------------------------------------------------------------------------------------------------

chmod +x ~/hypr/install/scripts/final-config.sh
~/hypr/install/scripts/final-config.sh

chmod +x ~/hypr/install/scripts/install-complete.sh
~/hypr/install/scripts/install-complete.sh
