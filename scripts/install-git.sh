#! /usr/bin/env bash

set -euo pipefail

# Check if git is build from source
if [[ ! "$(which git)" == *"/usr/local/"* ]]; then
  # Install build prerequisites
  sudo apt-get -qq install \
                   libz-dev \
                   libssl-dev \
                   libcurl4-gnutls-dev \
                   libexpat1-dev \
                   gettext \
                   cmake \
                   gcc

  # Switch to src folder
  pushd /usr/local/src

  # Remove artefacts
  for a in git-*; do
    if [ -d "$a" ]; then
      sudo rm -rf "$a"
    else
      sudo rm -f "$a"
    fi
  done

  # Set version number
  VERSION=2.38.0

  # Download Git
  sudo curl -o git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-$VERSION.tar.gz

  # Unpack the compressed tarball file:
  sudo tar -zxf git.tar.gz

  # Change owner & cd into dir
  sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER git-$VERSION
  cd git-$VERSION

  # Make the package
  make prefix=/usr/local all

  # Install Git
  if sudo make prefix=/usr/local install >/dev/null; then
    echo "Successfully installed Git $VERSION."
  else
    error "Failed to install Git $VERSION."
    popd && exit 1
  fi

  popd
fi
