#! /usr/bin/env bash

set -euo pipefail

# Check if virtualbox is installed
if ! command -v virtualbox >/dev/null 2>&1; then
  # Install build prerequisites
  sudo apt-get install software–properties–common

  # Install GPG keys
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add –

  # Add VirtualBox Repository 
  echo "deb [arch=amd64] http://virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

  # Update package list
  sudo apt-get update

  # Install VirtualBox
  if sudo apt-get install virtualbox–6.1 >/dev/null; then
    # Install VirtualBox Extension Pack
    wget https://download.virtualbox.org/virtualbox/6.1.26/Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack

    # Install the Extension Pack
    sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack

    # Add user to vboxusers group
    sudo usermod -aG vboxusers ${USER:=$(/usr/bin/id -run)} 

    echo "Successfully installed VirtualBox."
  else
    error "Failed to install VirtualBox."
    exit 1
  fi
fi
