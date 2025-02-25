#!/bin/bash
set -x

ARCH="amd64" # used instead of x86_64
OWNER="asdf-vm"
REPO="asdf"
TOOL="asdf"
BASE_URL=https://github.com/${OWNER}/${REPO}

function get_version_tag() {
	local URL=${BASE_URL}/releases/latest
	local REDIRECT_URL=$(curl -w "%{url_effective}\n" -I -L -s -S $URL -o /dev/null)
	local VERSION_TAG=$(echo $REDIRECT_URL | sed -E 's/.*\/tag\/(.*)/\1/gm')
	echo ${VERSION_TAG}
}

function download() {
	# Download the latest release
	sudo curl -LO ${BASE_URL}/releases/download/${VERSION_TAG}/${TAR_FILE}
}

function unpack() {
	# There is only a single file, so we'll put it in the local bin
	sudo tar -zxvf ${TAR_FILE} -C /usr/local/bin/
	sudo rm ${TAR_FILE}
}

VERSION_TAG=$(get_version_tag)
# SEM_VER=$(echo "${VERSION_TAG}" | sed "s/v//")
BASE_FILE=${TOOL}-${VERSION_TAG}-linux-${ARCH}
TAR_FILE=${BASE_FILE}.tar.gz

pushd /opt
download
unpack
popd
