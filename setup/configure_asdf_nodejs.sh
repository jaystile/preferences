#!/bin/bash

if ! command -v asdf 2>&1 >/dev/null
then
    echo "asdf could not be found. Try install_asdf.sh first."
    exit 1
fi
asdf plugin add nodejs
asdf install nodejs 23.8.0
asdf set -u nodejs 23.8.0

