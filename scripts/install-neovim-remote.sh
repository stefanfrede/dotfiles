#! /usr/bin/env bash

set -euo pipefail

# Check if Pip is installed
if command -v python -m pip --version >/dev/null 2>&1; then
  # Check if neovim-remote is installed
  if ! command -v nvr >/dev/null 2>&1; then
    # Install neovim-remote
    if pip install neovim-remote; then
      echo "Successfully installed neovim-remote."
    else
      echo "Failed to install neovim-remote."
      exit 1
    fi
  fi
else
  echo "Pip not found!"
  exit 1
fi
