#! /usr/bin/env bash

set -euo pipefail

# Check if Python is installed
if ! command -v python >/dev/null 2>&1; then
  # Install build prerequisites
  sudo apt-get -qq install \
                   wget build-essential \
                   libreadline-dev \
                   libncursesw5-dev \
                   libssl-dev \
                   libsqlite3-dev \
                   tk-dev \
                   libgdbm-dev \
                   libc6-dev \
                   libbz2-dev \
                   libffi-dev \
                   zlib1g-dev

  # Switch to src folder
  pushd /usr/local/src

  # Remove artefacts
  for a in Python-*; do
    if [ -d "$a" ]; then
      sudo rm -rf "$a"
    else
      sudo rm -f "$a"
    fi
  done

  # Set version number
  VERSION=3.10.2

  # Download Python
  sudo wget -c https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz

  # Uncompress tarball
  sudo tar -Jxf Python-$VERSION.tar.xz

  # Change owner & cd into dir
  sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER Python-$VERSION
  cd Python-$VERSION

  # Configure source
  ./configure --enable-optimizations

  # Install Python
  if sudo make altinstall >/dev/null; then
    # Make Python 3.10 default
    sudo update-alternatives --install /usr/bin/python python /usr/local/bin/python3.10 1
    sudo update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.10 1

    echo "Successfully installed Python $VERSION."
  else
    error "Failed to install Python $VERSION."
    popd && exit 1
  fi

  popd
fi
