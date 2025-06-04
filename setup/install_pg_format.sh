#!/bin/bash
set -x

ARCH="amd64" # used instead of x86_64
OWNER="darold"
REPO="pgFormatter"
TOOL="pg_format"
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
  sudo curl -LO ${BASE_URL}/archive/refs/tags/"${PKG_FILE}"
}

function install() {
  # Replaces the 'v' with nothing
  VERSION=${VERSION_TAG//v/}

  pushd /opt/pg_format/pgFormatter-"${VERSION}" || exit
  sudo apt install libcgi-pm-perl
  sudo apt install libjson-perl
  sudo perl Makefile.PL
  sudo make && sudo make install
  # install pg_format into /usr/local/bin/pg_format
  popd || exit
}

function unpack() {
  sudo mkdir -p /opt/$TOOL/
  sudo mv "$PKG_FILE" /opt/$TOOL/
  sudo chown -R "${USER}":users /opt/$TOOL
  pushd /opt/$TOOL/ || exit
  sudo tar -zxvf "${PKG_FILE}"
  sudo chown -R root:root /opt/$TOOL/
  popd || exit
}

VERSION_TAG=$(get_version_tag)
PKG_FILE=${VERSION_TAG}.tar.gz

pushd /opt || exit
download
unpack
install
# cleanup
sudo rm -rf /opt/$TOOL/
popd || exit
