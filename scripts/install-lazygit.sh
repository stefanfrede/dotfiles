#! /usr/bin/env bash

set -euo pipefail

# Check if lazygit is installed
if ! command -v lazygit >/dev/null 2>&1; then
	# Switch to downloads folder
	pushd ~/Downloads/

	# Get version
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

	# Download lazygit
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

	# Uncompress tarball
	tar xf lazygit.tar.gz lazygit

	# Install lazygit
	if sudo install lazygit /usr/local/bin >/dev/null; then
		echo "Successfully installed lazygit."
		echo "$(lazygit --version)"
	else
		error "Failed to install lazygit."
		popd && exit 1
	fi

	popd
fi
