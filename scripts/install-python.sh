#! /usr/bin/env bash

set -euo pipefail

if python3 --version >/dev/null; then
  echo "Python3 already installed."
else
  pushd /usr/local/src

  VERSION=3.10.2

  # Clean-up folder
  for p in Python-*; do
    if [ -d "$p" ]; then
      sudo rm -rf "$p"
    else
      sudo rm -f "$p"
    fi
  done

  # Update apt
  sudo apt update && sudo apt upgrade -y

  # Install prerequisites
  sudo apt install wget build-essential libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

  # Download Python
  sudo wget -c https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz

  # Uncompress tarball
  sudo tar -Jxf Python-$VERSION.tar.xz

  # Change owner & cd into dir
  sudo chown -R sfrede:sfrede Python-$VERSION
  cd Python-$VERSION

  # Configure source
  ./configure --enable-optimizations

  # Build source
  sudo make altinstall

  if pyton3.10 --version >/dev/null; then
    # Make Python 3.10 default
    sudo update-alternatives --install /usr/bin/python python /usr/local/bin/python3.10 1
    sudo update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.10 1

    echo "Python $VERSION installed succesfully."
  else
    echo "ERROR: Installing Python $VERSION failed!"
  fi

  popd
fi
