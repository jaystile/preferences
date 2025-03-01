#!/bin/bash

if ! command -v mix 2>&1 >/dev/null
then
    echo "mix could not be found. Try install_elixir.sh and configure_elixir.sh first."
    exit 1
fi

pushd /opt/elixir-ls/
mix deps.get
MIX_ENV=prod mix compile
MIX_ENV=prod mix elixir_ls.release2 -o release
popd

