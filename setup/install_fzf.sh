#!/bin/bash

# Remove the distribution's fzf and make your life easier to avoid path conflicts.

sudo apt remove fzf
pushd ~
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc --no-zsh --no-fish
popd
