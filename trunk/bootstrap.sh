#!/bin/bash
set -e
shopt -s extglob nullglob

export PKG_BASE=$(realpath "$(dirname "$0")")

rm -rf "${PKG_BASE}/Packager"
mkdir -p "${PKG_BASE}/Packager/var/lib/dpkg/info"

PKG_REQS=($(grep required "${PKG_BASE}"/data/!(*_)/_metadata/priority -l))

for PKG_NAME in "${PKG_REQS[@]}"; do
    PKG_NAME=${PKG_NAME%/_metadata/priority}
    PKG_NAME=${PKG_NAME##*/}

    export PKG_DEST=${PKG_BASE}/dest/${PKG_NAME}

    echo "merging ${PKG_NAME}..."
    cp -a "${PKG_DEST}"/* "${PKG_BASE}/Packager"

    "${PKG_BASE}/control.sh" "${PKG_NAME}" available >>"${PKG_BASE}/Packager/var/lib/dpkg/available"
    "${PKG_BASE}/control.sh" "${PKG_NAME}" status >>"${PKG_BASE}/Packager/var/lib/dpkg/status"

    (cd "${PKG_DEST}"; find | sed -e '
        s/^\.\///
        s/^/\//
    ') >"${PKG_BASE}/Packager/var/lib/dpkg/info/${PKG_NAME}.list"
done

cp -a "${PKG_BASE}/saurik.list" "${PKG_BASE}/Packager/etc/apt/sources.list.d"
cp -a "${PKG_BASE}/profile" "${PKG_BASE}/Packager/etc"
cd "${PKG_BASE}"
zip -ry Packager.zip Packager
rm -rf "${PKG_BASE}/Packager"
