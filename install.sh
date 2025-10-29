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

# Installation - Packages ------------------------------------------------------------------------------------

chmod +x ~/hypr/install/scripts/pretty-greeter-2.sh
~/hypr/install/scripts/pretty-greeter-2.sh

yay -S --needed - < ~/hypr/packages

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
chmod +x ~/.local/share/applications/openwebui.desktop ~/.local/share/applications/chatgpt.desktop ~/.local/share/applications/ncspot.desktop

cp -r ~/hypr/config/* ~/.config/
cp -r ~/hypr/local/* ~/.local/

echo "$USER ALL=(ALL) NOPASSWD: \
$(command -v cp) -r $HOME/.config/wlogout/themes/*/icons /usr/share/wlogout/icons, \
$(command -v cp) $HOME/.config/wlogout/themes/*/style.css /usr/share/wlogout/style.css, \
$(command -v rm) -rf /usr/share/wlogout/icons" \
| sudo tee /etc/sudoers.d/wlogout-theme >/dev/null

sudo cp -r ~/hypr/install/waybar/icons /etc/xdg/waybar/
cp -r ~/hypr/install/scripts/update.sh ~/

sudo chmod 440 /etc/sudoers.d/wlogout-theme
sudo visudo -cf /etc/sudoers.d/wlogout-theme

mkdir -p ~/.config/wallpapers/transparent
mkdir -p ~/.config/wallpapers/catppuccin
mkdir -p ~/.config/wallpapers/ultradark
unzip -o ~/.config/wallpapers/transparent.zip -d ~/.config/wallpapers/
unzip -o ~/.config/wallpapers/catppuccin.zip -d ~/.config/wallpapers/
unzip -o ~/.config/wallpapers/ultradark.zip -d ~/.config/wallpapers/

echo 'export PATH="$HOME/.local/bin:$HOME/.config/scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc

chmod +x ~/.config/scripts/*.sh ~/.config/scripts/switch-theme ~/.local/bin/toggle_caffeine

sudo usermod -a -G input $USER

~/.config/scripts/switch-theme transparent

chmod +x ~/hypr/install/scripts/install-complete.sh
~/hypr/install/scripts/install-complete.sh
