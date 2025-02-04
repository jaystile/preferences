#!/bin/bash
set -x

ARCH="amd64" # used instead of x86_64

function download() {
	# Download the latest release
	URL=https://github.com/syncthing/syncthing/releases/latest
	REDIRECT_URL=$(curl -w "%{url_effective}\n" -I -L -s -S $URL -o /dev/null)
	VERSION_TAG=$(echo $REDIRECT_URL | sed -E 's/.*\/tag\/(.*)/\1/gm')
	echo ${VERSION_TAG}

	sudo curl -LO https://github.com/syncthing/syncthing/releases/download/${VERSION_TAG}/syncthing-linux-${ARCH}-${VERSION_TAG}.tar.gz
	popd
}

function unpack() {
	# extract and link the tar file
	sudo tar -zxvf syncthing-linux-${ARCH}-${VERSION_TAG}.tar.gz
	sudo ln -s syncthing-linux-${ARCH}-${VERSION_TAG} syncthing
	
}
VERSION_TAG=v1.29.2

pushd /opt
# download
unpack
popd
