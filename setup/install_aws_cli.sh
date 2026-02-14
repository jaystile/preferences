#!/bin/bash
set -x

# Installation
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

ARCH="x86_64"
OWNER=
REPO=
TOOL="awscli"
BASE_URL=https://awscli.amazonaws.com

function download() {
  # Download the latest release
  sudo curl -LO ${BASE_URL}/"${ZIP_FILE}"
}

function unpack() {
  # There is only a single file, so we'll put it in the local bin
  sudo mkdir -p /opt/${TOOL}/bin
  sudo mkdir -p /opt/${TOOL}/unzipped
  unzip "${ZIP_FILE}" -d /opt/${TOOL}/unzipped

  sudo chown -R "${USER}":users /opt/${TOOL}

  sudo rm "${ZIP_FILE}"
}

function install() {
  # There is only a single file, so we'll put it in the local bin
  pushd /opt/${TOOL}/unzipped || exit
  sudo ./aws/install --bin-dir /opt/${TOOL}/bin --install-dir /opt/${TOOL} --update
  popd || exit

}

ZIP_FILE=awscli-exe-linux-${ARCH}.zip

pushd /opt || exit
download
unpack
install
popd || exit
