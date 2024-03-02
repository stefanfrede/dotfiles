#! /usr/bin/env bash

set -euo pipefail

# Check if Neovim is installed
if ! command -v wezterm >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s
	fi

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already a neovim folder
	if [[ ! -d "wezterm" ]]; then
		# Git clone WezTerm
		sudo git clone --depth=1 --branch=main --recursive https://github.com/wez/wezterm.git

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER wezterm
	fi

	# cd into folder and get the latest updates
	cd wezterm && git pull

	# Initialize submodules
	git submodule update --init --recursive

	# Get dependencies
	./get-deps

	# Install WezTerm
	if cargo build --release --no-default-features --features vendored-fonts >/dev/null; then
		# Copy the executable
		sudo cp target/release/wezterm /usr/local/bin
		sudo cp target/release/wezterm-gui /usr/local/bin
		sudo cp target/release/wezterm-mux-server /usr/local/bin

		sudo cp assets/open-wezterm-here /usr/local/bin

		mkdir -p ~/.local/share/applications
		cp assets/wezterm.desktop ~/.local/share/applications/org.wezfurlong.wezterm.desktop
		mkdir -p ~/.local/share/metainfo
		cp assets/wezterm.appdata.xml ~/.local/share/metainfo/org.wezfurlong.wezterm.appdata.xml
		mkdir -p ~/.local/share/icons/hicolor/128x128/apps
		cp assets/icon/terminal.png ~/.local/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png

		echo "Successfully installed WezTerm."
	else
		echo "Failed to install WezTerm."
		popd && exit 1
	fi

	popd
fi
