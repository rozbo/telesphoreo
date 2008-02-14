#!/bin/bash
set -e
shopt -s extglob nullglob

export PKG_BASE=$(realpath "$(dirname "$0")")
export PKG_BOOT=${PKG_BASE}/Packager

rm -rf "${PKG_BOOT}"
svn export "${PKG_BASE}/over" "${PKG_BOOT}"

arm-apple-darwin-gcc -o "${PKG_BOOT}/usr/libexec/cydia_/godmode" "${PKG_BASE}/tool/godmode.c"
arm-apple-darwin-gcc -o "${PKG_BOOT}/usr/libexec/cydia_/symlink" "${PKG_BASE}/tool/symlink.c"
chmod +s "${PKG_BOOT}/usr/libexec/cydia_/godmode"

mkdir -p "${PKG_BOOT}/var/lib/dpkg/info"

PKG_REQS=(adv-cmds base bash coreutils cydia gawk grep inetutils less libarmfp nano network-cmds saurik sed shell-cmds system-cmds unzip zip)

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
    echo "<array><string>Exec</string><string>/usr/libexec/cydia/symlink $(readlink "${link}") /${link}</string></array>"
    rm -f "${link}"
done >>../Packager.xml

mkdir -p usr/libexec/cydia/boot

cp -a bin/bash usr/libexec/cydia/boot
cp -a bin/df usr/libexec/cydia/boot
cp -a bin/ln usr/libexec/cydia/boot
cp -a bin/mktemp usr/libexec/cydia/boot
cp -a bin/mv usr/libexec/cydia/boot
cp -a usr/bin/basename usr/libexec/cydia/boot
cp -a usr/bin/du usr/libexec/cydia/boot
cp -a usr/lib/libhistory.5.2.dylib usr/libexec/cydia/boot
cp -a usr/lib/libintl.8.0.2.dylib usr/libexec/cydia/boot
cp -a usr/lib/libncurses.5.dylib usr/libexec/cydia/boot
cp -a usr/lib/libreadline.5.2.dylib usr/libexec/cydia/boot

rm -f ../Packager.zip
zip -qry ../Packager.zip *
rm -rf "${PKG_BOOT}"
