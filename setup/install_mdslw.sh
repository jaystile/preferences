#!/bin/bash
if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo could not be found. Try install_rust.sh first."
  exit 1
fi

# Download the source
pushd /opt || exit
sudo git clone https://github.com/razziel89/mdslw
sudo chown -R "$USER":users mdslw
cargo install --locked --path mdslw
popd || exit
