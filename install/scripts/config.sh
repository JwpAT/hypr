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

echo "$USER ALL=(ALL) NOPASSWD: /bin/cp -r $HOME/.config/themes/*/wlogout/icons /usr/share/wlogout/icons, /bin/cp $HOME/.config/themes/*/wlogout/style.css /usr/share/wlogout/style.css, /bin/rm -rf /usr/share/wlogout/icons" | sudo tee /etc/sudoers.d/wlogout-theme
sudo chmod 440 /etc/sudoers.d/wlogout-theme

echo 'export PATH="$HOME/.local/bin:$HOME/.config/scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc
chmod +x ~/.config/scripts/switch-theme
chmod +x ~/.config/scripts/wofi-theme.sh
~/.config/scripts/switch-theme transparent
