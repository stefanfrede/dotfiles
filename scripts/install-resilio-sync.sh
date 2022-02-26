#! /usr/bin/env bash

set -euo pipefail

# Check if virtualbox is installed
if ! command -v rslsync >/dev/null 2>&1; then
  # Add public key
  curl -L https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add - 

  # Register Resilio repository
  echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list

  # Update packages index
  sudo apt-get update

  # Install Resilio Sync
  if sudo apt-get install resilio-sync >/dev/null; then
    # Enable automatic startup
    sudo systemctl enable resilio-sync

    # Add user to rslsync group
    sudo usermod -aG ${USER:=$(/usr/bin/id -run)} rslsync
    sudo usermod -aG rslsync $USER 

    # Add sync folder
    mkdir ~/Dropbox
    sudo chmod g+rw ~/Dropbox

    rslsync --config ~/.config/rslsync/sync.conf

    echo "Successfully installed Resilio Sync."
  else
    error "Failed to install Resilio Sync."
    exit 1
  fi
fi
