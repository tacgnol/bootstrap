#!/bin/sh

if [ -d "${HOME}/.local/share/bootstrap" ]; then
  rm -rf "${HOME}/.local/share/bootstrap"
fi

if [ -d "${HOME}/.cache/bootstrap" ]; then
  rm -rf "${HOME}/.cache/bootstrap"
fi

echo "🚀  Dotfiles bootstrapped"

