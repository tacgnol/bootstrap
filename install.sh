#!/bin/bash

set -eufo pipefail

echo ""
echo "🤚  This script will setup .dotfiles for you."
read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

if [ ! "$(command -v age)" ]; then
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/tacgnol/bootstrap/main/scripts/age.sh)" -- -b "$bin_dir"
  else
    sh -c "$(wget -qO- https://raw.githubusercontent.com/tacgnol/bootstrap/main/scripts/.sh)" -- -b "$bin_dir"
  fi
else
  age=age
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: replace current process with chezmoi init
exec "$chezmoi" -S ~/.local/share/bootstrap init --apply https://github.com/tacgnol/bootstrap.git

if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
  echo "🚸  chezmoi already initialized"
else
  echo "🚀  Initialize dotfiles with:"
  echo "    chezmoi init https://github.com/tacgnol/bootstrap.git"
fi

echo ""
echo "Done."
