#! /usr/bin/env bash

set -euo pipefail

# Check if gh is installed
if ! command -v gh >/dev/null 2>&1; then
  # Add official gh packages to sources
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

  # Update sources
  sudo apt-get -qq update

  # Install gh
  if sudo sudo apt install gh >/dev/null; then
    echo "Successfully installed gh."
  else
    error "Failed to install gh."
    popd && exit 1
  fi

  popd
fi
