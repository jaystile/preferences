#!/bin/bash
git clone https://github.com/jaystile/kickstart.nvim  "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim


# null-ls uses prettier, so asdf needs to be installed with npm
echo ./install_asdf.sh
echo asdf install nodejs 23.8.0
echo asdf set nodejs 23.8.0
echo npm install prettier
