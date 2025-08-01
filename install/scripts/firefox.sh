#!/bin/bash

# Configuring Firefox for Open WebUI
echo "Configuring Firefox profile for Open WebUI..."
firefox -CreateProfile "ai /home/$USER/.mozilla/firefox/ai"
mkdir -p ~/.mozilla/firefox/ai
cp -r ~/hypr/install/firefox/ai/chrome ~/.mozilla/firefox/ai/
echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> ~/.mozilla/firefox/ai/user.js

# Configuring Main Firefox Profile
echo "✔️ Configuring main Firefox profile..."
firefox -CreateProfile "default /home/$USER/.mozilla/firefox/default"
mkdir -p ~/.mozilla/firefox/default
cp -r ~/hypr/install/firefox/default/chrome ~/.mozilla/firefox/default/
echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> ~/.mozilla/firefox/default/user.js

# Overwrite the generated profiles.ini and installs.ini
echo "copying profiles.ini and installs.ini..."
cp ~/hypr/install/firefox/profiles.ini ~/.mozilla/firefox/
cp ~/hypr/install/firefox/installs.ini ~/.mozilla/firefox/

echo "Firefox has been configured"
sleep 2
