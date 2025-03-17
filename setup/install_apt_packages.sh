#!/bin/bash

sudo apt update # get the latest packages

# nvim kick start dependencies
sudo apt install -y \
  ripgrep \
  xsel \
  fonts-noto-color-emoji

# pyenv dependencies
sudo apt install -y \
  tk-dev \
  libpq-dev

# phoenix framework dependencies
supo apt install -y inotify-tools

# plantuml dependencies
sudo apt install -y graphviz

# personal preferences
sudo apt install -y \
  postgresql-client \
  shellcheck
