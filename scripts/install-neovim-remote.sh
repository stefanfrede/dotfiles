#! /usr/bin/env bash

set -euo pipefail

if python3 -m pip --version >/dev/null; then
  if nvr --version >/dev/null; then
    echo "neovim-remote already installed."
  else
    pip3 install neovim-remote

    echo "neovim-remote installed succesfully."
  fi
else
  echo "ERROR: pip not found!"
fi
