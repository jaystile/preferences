#!/bin/bash
pushd /opt || exit
ARCH=$(uname -m)
sudo rm -rf /opt/nvim
sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-"${ARCH}".tar.gz
sudo tar -C /opt -xzf nvim-linux-"${ARCH}".tar.gz
sudo ln -s nvim-linux-"${ARCH}" nvim
sudo rm nvim-linux-"${ARCH}".tar.gz
popd || exit
