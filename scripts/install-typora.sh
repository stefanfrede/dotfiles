#! /usr/bin/env bash

set -euo pipefail

# Check if Typora is installed
if ! command -v typora >/dev/null 2>&1; then
	# Add public key
	wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -

	# Register Typora repository
	sudo add-apt-repository 'deb https://typora.io/linux ./'

	# Update packages index
	sudo apt-get update

	# Install Typora
	if sudo apt-get install typora >/dev/null; then
		echo "Successfully installed Typora."
	else
		error "Failed to install Typora."
		exit 1
	fi
fi
