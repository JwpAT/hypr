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
