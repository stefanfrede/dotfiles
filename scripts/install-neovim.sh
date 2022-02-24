#! /usr/bin/env bash

set -euo pipefail

# Check if Neovim is installed
if ! command -v nvim >/dev/null 2>&1; then
  # Install build prerequisites
  sudo apt-get -qq install \
                   ninja-build \
                   gettext \
                   libtool \
                   libtool-bin \
                   autoconf \
                   automake \
                   cmake \
                   g++ \
                   pkg-config \
                   unzip \
                   curl \
                   doxygen

  # Switch to src folder
  pushd /usr/local/src

  # Check if there is already a neovim folder
  if [[ ! -d "neovim" ]]; then
    # Git clone Neovim
    git clone https://github.com/neovim/neovim

    # Change owner
    sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER neovim
  fi

  # cd into folder, get the latest updates, and switch to branch stable
  cd neovim && git checkout master && git pull && git checkout stable

  # Clean-up build deps and build source
  make disclean && make CMAKE_BUILD_TYPE=Release

  # Install Neovim
  if sudo make install >/dev/null; then
    echo "Successfully installed Neovim."
  else
    echo "Failed to install Neovim."
    popd && exit 1
  fi

  popd
fi
