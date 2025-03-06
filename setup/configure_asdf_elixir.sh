#!/bin/bash

if ! command -v asdf 2>&1 >/dev/null
then
    echo "asdf could not be found. Try install_asdf.sh first."
    exit 1
fi

asdf plugin add erlang
asdf plugin add elixir
asdf install erlang 27.2.4
asdf set -u erlang 27.2.4
asdf install elixir 1.18.2-otp-27
asdf set -u elixir 1.18.2-otp-27
