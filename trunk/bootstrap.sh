#!/bin/bash
set -e
shopt -s extglob nullglob

export PKG_BASE=$(realpath "$(dirname "$0")")
export PKG_BOOT=${PKG_BASE}/Packager

rm -rf "${PKG_BOOT}"
svn export "${PKG_BASE}/over" "${PKG_BOOT}"

mkdir -p "${PKG_BOOT}/var/lib/dpkg/info"

PKG_REQS=(adv-cmds base coreutils cydia gawk grep inetutils nano network-cmds nvi saurik sed shell-cmds system-cmds unzip zip)

cd "${PKG_BASE}/data"
PKG_REQS=($(find -L "${PKG_REQS[@]}" | while read -r line; do realpath "${line}"; done | grep "/home/saurik/telesphoreo/data/[^/]*$" | sed -e 's/.*\///' | sort -u))

for PKG_NAME in "${PKG_REQS[@]}"; do
    PKG_NAME=${PKG_NAME%/_metadata/priority}
    PKG_NAME=${PKG_NAME##*/}

    export PKG_DEST=${PKG_BASE}/dest/${PKG_NAME}

    echo "merging ${PKG_NAME}..."
    cp -a "${PKG_DEST}"/* "${PKG_BOOT}"

    "${PKG_BASE}/control.sh" "${PKG_NAME}" available >>"${PKG_BOOT}/var/lib/dpkg/available"
    "${PKG_BASE}/control.sh" "${PKG_NAME}" status >>"${PKG_BOOT}/var/lib/dpkg/status"

    (cd "${PKG_DEST}"; find | sed -e '
        s/^\.\///
        s/^/\//
    ') >"${PKG_BOOT}/var/lib/dpkg/info/${PKG_NAME}.list"
done

cd "${PKG_BOOT}"

rm -f ../Packager.xml
find * -type l -print -o -name "terminfo" -prune | while read -r link; do
    echo "<array><string>Exec</string><string>/bin/ln -fs $(readlink "${link}") /${link}</string></array>"
    rm -f "${link}"
done >>../Packager.xml

rm -f ../Packager.zip
zip -qry ../Packager.zip *
rm -rf "${PKG_BOOT}"
