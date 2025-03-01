#!/bin/bash

if ! command -v asdf 2>&1 >/dev/null
then
    echo "asdf could not be found. Try install_asdf.sh first."
    exit 1
fi

# none-ls uses prettier, so asdf needs to be installed with npm
asdf install nodejs 23.8.0
asdf set -u nodejs 23.8.0
npm install prettier

git clone https://github.com/jaystile/kickstart.nvim  "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
