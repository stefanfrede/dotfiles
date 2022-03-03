#! /usr/bin/env bash

set -euo pipefail

DIR=/home/sfrede/Downloads/
FILE=FileZilla_Pro_*.tar.bz2

# Check if a FileZilla file is in the Downloads folder
if compgen -G "${DIR}${FILE}" >/dev/null 2>&1; then
  pushd /usr/local/src

  # Remove artefacts
  for f in FileZilla*; do
    if [ -d "$f" ]; then
      sudo rm -rf "$f"
    else
      sudo rm -f "$f"
    fi
  done

  # Copy archive to /usr/local/src
  sudo find $DIR -name "${FILE}" -exec mv '{}' /usr/local/src/ \;

  # Untar archive
  for f in FileZilla*; do
    if [ -f "$f" ]; then
      sudo tar -xf"$f" 
    fi
  done

  # Change owner
  for f in FileZilla*; do
    if [ -d "$f" ]; then
      sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER $f
    fi
  done

  # Remove FileZilla symlink
  sudo rm /usr/local/bin/filezilla

  # Install FileZilla
  if sudo ln -s /usr/local/src/FileZilla3/bin/filezilla /usr/local/bin/filezilla >/dev/null; then
    echo "Successfully installed FileZilla."
  else
    error "Failed to install FileZilla."
    popd && exit 1
  fi

  popd
fi
