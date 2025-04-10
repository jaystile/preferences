#!/bin/bash
set -x

ARCH="X64" # used instead of x86_64
OWNER="llvm"
REPO="llvm-project"
TOOL="llvm"
BASE_URL=https://github.com/${OWNER}/${REPO}

function get_version_tag() {
  local URL=${BASE_URL}/releases/latest
  local REDIRECT_URL
  REDIRECT_URL=$(curl -w "%{url_effective}\n" -I -L -s -S $URL -o /dev/null)
  local VERSION_TAG
  VERSION_TAG="$(echo "$REDIRECT_URL" | sed -E 's/.*\/tag\/(.*)/\1/gm')"
  echo "${VERSION_TAG}"
}

function download() {
  # Download the latest release
  sudo curl -LO ${BASE_URL}/releases/download/"${VERSION_TAG}"/"${TAR_FILE}"
}

function unpack() {
  # There is only a single file, so we'll put it in the local bin
  sudo tar -C /opt -xvf "${TAR_FILE}"
  sudo ln -s "${BASE_FILE}" ${TOOL}
  sudo chown -R "${USER}":users /opt/${TOOL}
  sudo rm "${TAR_FILE}"
}

VERSION_TAG=$(get_version_tag)
SEM_VER=$(echo "${VERSION_TAG}" | sed "s/llvmorg-//")
BASE_FILE=${TOOL^^}-${SEM_VER}-Linux-${ARCH}
TAR_FILE=${BASE_FILE}.tar.xz

pushd /opt || exit
download
unpack
popd || exit
