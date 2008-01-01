#!/bin/bash
set -e
shopt -s extglob nullglob

export PKG_MAKE=$0
export PKG_NAME=${1%_}

export PKG_BASE=$(realpath "$(dirname "$0")")
. "${PKG_BASE}/helper.sh"

./make.sh "${PKG_NAME}"

pkg: mkdir -p /DEBIAN
./control.sh "${PKG_NAME}" control >"$(pkg_ /DEBIAN/control)"
dpkg-deb -b "${PKG_DEST}" "${PKG_PACK}"
pkg: rm -rf /DEBIAN
