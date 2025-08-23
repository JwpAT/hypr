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

cp -r ~/hypr/install/applications ~/.local/share/
chmod +x ~/.local/share/applications/openwebui.desktop ~/.local/share/applications/chatgpt.desktop

cp -r ~/hypr/config/* ~/.config/
chmod +x ~/.config/scripts/hyprlock-greeter.sh ~/.config/scripts/wireless-menu.sh ~/.config/scripts/waybar-weather.sh

mkdir -p ~/.config/kitty ~/.config/hyprlock-walls ~/.config/waybar ~/.config/wofi
chmod +x ~/.config/scripts/notify.sh

# Allow passwordless copy/remove for your wlogout theme assets
echo "$USER ALL=(ALL) NOPASSWD: \
$(command -v cp) -r $HOME/.config/wlogout/themes/*/icons /usr/share/wlogout/icons, \
$(command -v cp) $HOME/.config/wlogout/themes/*/style.css /usr/share/wlogout/style.css, \
$(command -v rm) -rf /usr/share/wlogout/icons" \
| sudo tee /etc/sudoers.d/wlogout-theme >/dev/null

sudo chmod 440 /etc/sudoers.d/wlogout-theme
# sanity-check the file:
sudo visudo -cf /etc/sudoers.d/wlogout-theme

echo 'export PATH="$HOME/.local/bin:$HOME/.config/scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc
chmod +x ~/.config/scripts/switch-theme
chmod +x ~/.config/scripts/wofi-theme.sh
~/.config/scripts/switch-theme transparent

chmod +x ~/hypr/install/scripts/install-complete.sh
~/hypr/install/scripts/install-complete.sh
