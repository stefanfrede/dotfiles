#! /usr/bin/env bash

set -euo pipefail

# Check if node is installed
if command -v node >/dev/null 2>&1; then
	# Install Node Package Manager
	npm i -g npm
	# Install Neovim Client
	npm i -g neovim
	# Install Linters
	npm i -g eslint
	npm i -g prettier
	npm i -g stylelint
	# Install CLIs
	npm i -g netlify-cli
	npm i -g @sanity/cli
	npm i -g storyblok
fi
