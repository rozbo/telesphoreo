#!/bin/bash
set -e
shopt -s extglob nullglob

export PKG_BASE=$(realpath "$(dirname "$0")")
source "${PKG_BASE}/architect.sh"

export PKG_BOOT=${PKG_BASE}/Packager

rm -rf "${PKG_BOOT}"
svn export "${PKG_BASE}/over" "${PKG_BOOT}"

"${PKG_TARG}-gcc" -o "${PKG_BOOT}/usr/libexec/cydia_/godmode" "${PKG_BASE}/util/godmode.c"
"${PKG_TARG}-gcc" -o "${PKG_BOOT}/usr/libexec/cydia_/symlink" "${PKG_BASE}/util/symlink.c"
chmod +s "${PKG_BOOT}/usr/libexec/cydia_"/{godmode,symlink}

mkdir -p "${PKG_BOOT}/var/lib/dpkg/info"

PKG_REQS=(adv-cmds apt base bash coreutils cydia cydia-sources gawk grep inetutils less libarmfp libgcc nano network-cmds nvi rsync sed shell-cmds system-cmds tar unzip zip)

cd "${PKG_BASE}/data"
PKG_REQS=($({
    echo "${PKG_REQS[@]}" | tr ' ' $'\n'
    find -L "${PKG_REQS[@]}" -name '*.dep' | sed -e 's/.*\/\([^\/]*\)\.dep/\1/'
} | sort -u))

for PKG_NAME in "${PKG_REQS[@]}"; do
    PKG_NAME=${PKG_NAME%/_metadata/priority}
    PKG_NAME=${PKG_NAME##*/}
    source "${PKG_BASE}/helper.sh"

    rm -rf "${PKG_BASE}/temp"
    dpkg -x "${PKG_BASE}/debs/${PKG_NAME}_${PKG_VRSN}-${PKG_RVSN}_${PKG_ARCH}.deb" "${PKG_BASE}/temp"

    echo "merging ${PKG_NAME}..."
    files=("${PKG_BASE}/temp"/*)
    if [[ ${#files[@]} -ne 0 ]]; then
        cp -a "${PKG_BASE}/temp"/* "${PKG_BOOT}"
    fi

    "${PKG_BASE}/control.sh" "${PKG_NAME}" available >>"${PKG_BOOT}/var/lib/dpkg/available"
    "${PKG_BASE}/control.sh" "${PKG_NAME}" status >>"${PKG_BOOT}/var/lib/dpkg/status"

    (cd "${PKG_BASE}/temp"; find | sed -e '
        s/^\.\///
        s/^/\//
    ') >"${PKG_BOOT}/var/lib/dpkg/info/${PKG_NAME}.list"
done

cd "${PKG_BOOT}"

rm -f "../Packager_${PKG_ARCH}.tgz"
tar -zcvf "../Packager_${PKG_ARCH}.tgz" *

rm -f "../Packager_${PKG_ARCH}_.zip"
zip -ry "../Packager_${PKG_ARCH}_.zip" *

cp -a bin/bash usr/libexec/cydia_
cp -a bin/chmod usr/libexec/cydia_
cp -a bin/chown usr/libexec/cydia_
cp -a bin/cp usr/libexec/cydia_
cp -a bin/df usr/libexec/cydia_
cp -a bin/grep usr/libexec/cydia_
cp -a bin/ln usr/libexec/cydia_
cp -a bin/mkdir usr/libexec/cydia_
cp -a bin/mktemp usr/libexec/cydia_
cp -a bin/rm usr/libexec/cydia_
cp -a bin/sed usr/libexec/cydia_
cp -a sbin/reboot usr/libexec/cydia_
cp -a usr/bin/basename usr/libexec/cydia_
cp -a usr/bin/du usr/libexec/cydia_
cp -a usr/lib/libhistory.5.2.dylib usr/libexec/cydia_
cp -a usr/lib/libintl.8.0.2.dylib usr/libexec/cydia_
cp -a usr/lib/libncurses.5.dylib usr/libexec/cydia_
cp -a usr/lib/libreadline.5.2.dylib usr/libexec/cydia_
cp -a usr/libexec/cydia/move.sh usr/libexec/cydia_

rm -f "../Packager_${PKG_ARCH}.xml"
find * -type l -print -o -name "terminfo" -prune | while read -r link; do
    echo "<array><string>Exec</string><string>/usr/libexec/cydia_/symlink $(readlink "${link}") /${link}</string></array>"
    rm -f "${link}"
done >>"../Packager_${PKG_ARCH}.xml"

rm -f "../Packager_${PKG_ARCH}.zip"
zip -qry "../Packager_${PKG_ARCH}.zip" *
rm -rf "${PKG_BOOT}"
