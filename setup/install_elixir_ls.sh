#!/bin/bash
set -x
#  900  elixir-ls
#  903  mkdir elixir-ls
#  904  sudo chown jason:users elixir-ls
#  907  git clone git@github.com:elixir-lsp/elixir-ls.git ~/.elixir-ls
#  909  cd ~/.elixir-ls/
#  910  mv ~/.elixir-ls/* .
#  911  rmdir ~/.elixir-ls/
#  912  git clone git@github.com:elixir-lsp/elixir-ls.git
#  913  rm -rf ~/.elixir-ls/
#  916  rm -rf /opt/elixir-ls/
#  917  sudo rm -rf /opt/elixir-ls/
#  918  sudo mkdir elixir-ls
#  919  sudo chown jason:users elixir-ls/
#  920  git clone git@github.com:elixir-lsp/elixir-ls.git
#  921  rm -rf elixir-ls/
#  922  git clone git@github.com:elixir-lsp/elixir-ls.git .
#  937  ls -la /opt/elixir-ls/release/language_server.sh
#  941  which elixir-ls
#  942  cd /opt/elixir-ls/
#  958  cd elixir-ls/
#  960  history | grep elixir-ls

ARCH="amd64" # used instead of x86_64
OWNER="elixir-lsp"
REPO="elixir-ls"
TOOL="elixir-ls"
BASE_URL=https://github.com/${OWNER}/${REPO}

function get_version_tag() {
    local URL=${BASE_URL}/releases/latest
    local REDIRECT_URL=$(curl -w "%{url_effective}\n" -I -L -s -S $URL -o /dev/null)
    local VERSION_TAG=$(echo $REDIRECT_URL | sed -E 's/.*\/tag\/(.*)/\1/gm')
    echo ${VERSION_TAG}
}

function download() {
    # Download the latest release
    sudo curl -L -o ${TAR_FILE} ${BASE_URL}/archive/refs/tags/${BASE_FILE}.tar.gz
}

function unpack() {
    # There is only a single file, so we'll put it in the local bin
    sudo tar -zxvf ${TAR_FILE}
    sudo chown -R ${USER}:users /opt/${TOOL}-${SEM_VER}
    sudo rm elixir-ls
    sudo ln -s ${TOOL}-${SEM_VER} elixir-ls
    sudo rm ${TAR_FILE}
}

VERSION_TAG=$(get_version_tag)
SEM_VER=$(echo "${VERSION_TAG}" | sed "s/v//")
BASE_FILE=${VERSION_TAG}
TAR_FILE=${TOOL}-${BASE_FILE}.tar.gz

pushd /opt
download
unpack
popd
