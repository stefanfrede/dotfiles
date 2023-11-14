#! /usr/bin/env bash

set -euo pipefail

# Check if xsel is installed
if ! command -v xsel >/dev/null 2>&1; then
	# Install xsel
	if sudo apt-get -qq install xsel -y; then
		echo "Successfully installed xsel."
	else
		echo "Failed to install xsel."
		exit 1
	fi
fi

# Check if fish shell is installed
# https://fishshell.com/
if ! command -v fish >/dev/null 2>&1; then
	# Install build prerequisites
	sudo apt-get -qq install \
		build-essential \
		cmake \
		libncurses5-dev \
		libncursesw5-dev \
		gettext

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already an fish-shell folder
	if [[ ! -d "fish-shell" ]]; then
		# Git clone folder
		sudo git clone https://github.com/fish-shell/fish-shell

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER fish-shell
	fi

	# cd into folder and get the latest updates
	cd fish-shell && git pull >/dev/null 2>&1

	# Configure and build pakage
	cmake . && make

	# Install fish shell
	if sudo make install >/dev/null; then
		# Add fish shell to /etc/shells
		echo /usr/local/bin/fish | sudo tee -a /etc/shells

		# Use fish shell as default shell
		sudo chsh -s /usr/local/bin/fish $USER

		echo "Successfully installed fish shell."
	else
		echo "Failed to install fish shell."
		exit 1
	fi
fi

# Check if asdf is installed
# https://asdf-vm.com/
if ! command -v asdf >/dev/null 2>&1; then
	# Install asdf
	if git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0 &>/dev/null; then
		# Copy the shell completion file
		sudo cp ~/.asdf/completions/asdf.fish /usr/share/fish/vendor_completions.d

		echo "Successfully installed asdf."
	else
		echo "Failed to install asdf."
		exit 1
	fi
fi

# Check if node is installed
if ! command -v node >/dev/null 2>&1; then
	asdf update

	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf install nodejs latest
	asdf global nodejs latest

	source ./install-global-node-modules.sh
fi

# Check if ruby is installed
if ! command -v ruby >/dev/null 2>&1; then
	# Set version number
	VERSION=3.1.1

	asdf update

	asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
	asdf install ruby $VERSION
	asdf global ruby $VERSION

	source ./install-global-ruby-gems.sh
fi

# Check if exa is installed
# https://the.exa.website/
if ! command -v exa >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# Install build prerequisites
	sudo apt-get -qq install \
		libgit2 \
		cmake

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already an exa folder
	if [[ ! -d "exa" ]]; then
		# Git clone folder
		git clone git clone https://github.com/ogham/exa.git

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER exa
	fi

	# cd into folder and get the latest updates
	cd exa && git pull >/dev/null 2>&1

	# Install exa
	if cargo build --release >/dev/null; then
		# Copy the executable
		sudo cp target/release/exa /usr/local/bin

		# Copy the shell completion file
		sudo cp completions/fish/exa.fish /usr/share/fish/vendor_completions.d

		echo "Successfully installed exa."
	else
		echo "Failed to install exa."
		popd && exit 1
	fi

	popd
fi

# Check if bat is installed
# https://github.com/sharkdp/bat/
if ! command -v bat >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already an bat folder
	if [[ ! -d "bat" ]]; then
		# Git clone folder
		sudo git clone https://github.com/sharkdp/bat

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER fd
	fi

	# cd into folder and get the latest updates
	cd bat && git pull >/dev/null 2>&1

	# Install bat
	if cargo build --release >/dev/null; then
		# Copy the executable
		sudo cp target/release/bat /usr/local/bin

		echo "Successfully installed bat."
	else
		echo "Failed to install bat."
		popd && exit 1
	fi

	popd
fi

# Check if fd is installed
# https://github.com/sharkdp/fd/
if ! command -v fd >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already an fd folder
	if [[ ! -d "fd" ]]; then
		# Git clone folder
		sudo git clone https://github.com/sharkdp/fd

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER fd
	fi

	# cd into folder and get the latest updates
	cd fd && git pull >/dev/null 2>&1

	# Install fd
	if cargo build --release >/dev/null; then
		# Copy the executable
		sudo cp target/release/fd /usr/local/bin

		echo "Successfully installed fd."
	else
		echo "Failed to install fd."
		popd && exit 1
	fi

	popd
fi

# Check if ripgrep is installed
# https://github.com/BurntSushi/ripgrep/
if ! command -v rg >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already an ripgrep folder
	if [[ ! -d "ripgrep" ]]; then
		# Git clone folder
		sudo git clone https://github.com/BurntSushi/ripgrep

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER ripgrep
	fi

	# cd into folder and get the latest updates
	cd ripgrep && git pull >/dev/null 2>&1

	# Install fd
	if cargo build --release >/dev/null; then
		# Copy the executable
		sudo cp target/release/rg /usr/local/bin

		echo "Successfully installed ripgrep."
	else
		echo "Failed to install ripgrep."
		popd && exit 1
	fi

	popd
fi

# Check if delta is installed
# https://dandavison.github.io/delta/
if ! command -v rg >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already an delta folder
	if [[ ! -d "delta" ]]; then
		# Git clone folder
		sudo git clone https://github.com/dandavison/delta.git

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER delta
	fi

	# cd into folder and get the latest updates
	cd delta && git pull >/dev/null 2>&1

	# Install fd
	if cargo build --release >/dev/null; then
		# Copy the executable
		sudo cp target/release/delta /usr/local/bin

		echo "Successfully installed delta."
	else
		echo "Failed to install delta."
		popd && exit 1
	fi

	popd
fi

# Check if wezterm is installed
# https://github.com/wez/
if ! command -v wezterm >/dev/null 2>&1; then

	# Switch to src folder
	pushd ~/Downloads

	# Download wezterm for Ubuntu 20.04
	curl -LO https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu20.04.deb

	# Install fd
	sudo apt install -y ./wezterm-20230712-072601-f4abf8fd.Ubuntu20.04.deb

	popd
fi

# Check if tree-sitter is installed
# https://tree-sitter.github.io/tree-sitter/
if ! command -v tree-sitter >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# Switch to src folder
	pushd /usr/local/src

	# Check if there is already an tree-sitter folder
	if [[ ! -d "tree-sitter" ]]; then
		# Git clone folder
		sudo git clone https://github.com/tree-sitter/tree-sitter.git

		# Change owner
		sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER tree-sitter
	fi

	# cd into folder and get the latest updates
	cd tree-sitter && git pull >/dev/null 2>&1

	# Install tree-sitter
	if cargo build --release >/dev/null; then
		# Copy the executable
		sudo cp target/release/tree-sitter /usr/local/bin

		echo "Successfully installed tree-sitter."
	else
		echo "Failed to install tree-sitter."
		popd && exit 1
	fi

	popd
fi

# Check if stylua is installed
# https://github.com/JohnnyMorganz/StyLua/
if ! command -v stylua >/dev/null 2>&1; then
	# Install Rust
	if ! command -v rustup >/dev/null 2>&1; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# Install stylua
	cargo install stylua --features lua54
fi

# Check if fzf is installed
# https://github.com/junegunn/fzf
if ! command -v fzf >/dev/null 2>&1; then
	if git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &>/dev/null; then
		~/.fzf/install

		echo "Successfully installed fzf."
	else
		echo "Failed to install fzf."
		exit 1
	fi
fi

# Check if starship is installed
# https://starship.rs/
if ! command -v starship >/dev/null 2>&1; then
	sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi

# Check if mosh is installed
# https://mosh.org/
if ! command -v mosh >/dev/null 2>&1; then
	# Install mosh
	if sudo apt-get -qq install mosh -y; then
		echo "Successfully installed mosh."
	else
		echo "Failed to install mosh."
		exit 1
	fi
fi

# Check if htop is installed
if ! command -v htop >/dev/null 2>&1; then
	# Install xsel
	if sudo apt-get -qq install htop -y; then
		echo "Successfully installed htop."
	else
		echo "Failed to install htop."
		exit 1
	fi
fi

# Check if deno is installed
# https://deno.land/
if ! command -v deno >/dev/null 2>&1; then
	sh -c "$(curl -fsSL https://deno.land/x/install/install.sh)"
fi
