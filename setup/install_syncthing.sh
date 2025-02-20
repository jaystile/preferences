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
	sudo ln -fs syncthing-linux-${ARCH}-${VERSION_TAG} syncthing
	sudo chown -R root:root syncthing-linux-${ARCH}-${VERSION_TAG} 
	sudo rm syncthing-linux-${ARCH}-${VERSION_TAG}
	
}

function autostart() {
	# automatically start syncthing as the user
	mkdir -p ~/.config/systemd/user
	sudo ln -fs /opt/syncthing/syncthing /usr/bin/syncthing
	ln -fs /opt/syncthing/etc/linux-systemd/user/syncthing.service ~/.config/systemd/user/syncthing.service
	systemctl --user enable syncthing.service
	systemctl --user start syncthing.service
	echo "Execute the following:"
	echo "systemctl --user status syncthing.service"
}

pushd /opt
download
unpack
autostart
popd
