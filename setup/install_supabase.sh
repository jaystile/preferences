#!/bin/bash
set -x

ARCH="amd64" # used instead of x86_64
OWNER="supabase"
REPO="cli"
TOOL="supabase"
BASE_URL=https://github.com/${OWNER}/${REPO}

function get_version_tag() {
  local URL REDIRECT_URL VERSION_TAG
  URL=${BASE_URL}/releases/latest
  REDIRECT_URL=$(curl -w "%{url_effective}\n" -I -L -s -S $URL -o /dev/null)
  VERSION_TAG=$(echo "$REDIRECT_URL" | sed -E 's/.*\/tag\/(.*)/\1/gm')
  echo "${VERSION_TAG}"
}

function download() {
  # Download the latest release
  sudo curl -LO ${BASE_URL}/releases/download/"${VERSION_TAG}"/"${PKG_FILE}"
}

function unpack() {
  # There is only a single file, so we'll put it in the local bin
  sudo mkdir -p /opt/$TOOL/
  sudo mv "$PKG_FILE" /opt/$TOOL/
  sudo chown -R "${USER}":users /opt/$TOOL
  pushd /opt/$TOOL/ || exit
  sudo tar -zxvf "${PKG_FILE}"
  sudo chown -R root:root /opt/$TOOL/
  rm "${PKG_FILE}"

  popd || exit
}

VERSION_TAG=$(get_version_tag)
## TODO: Remove? SEM_VER=$(echo "${VERSION_TAG}" | sed "s/v//")
# Replaces the 'v' with nothing
# SEM_VER=${VERSION_TAG//v/}
BASE_FILE=${TOOL}_linux_${ARCH}
PKG_FILE=${BASE_FILE}.tar.gz

pushd /opt || exit
download
unpack
popd || exit
