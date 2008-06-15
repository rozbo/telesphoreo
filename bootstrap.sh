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

    cd "${PKG_BASE}"
    ./package.sh "${PKG_NAME}"

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

rm -rf "${PKG_BASE}/temp"
cd "${PKG_BOOT}"

PKG_RSLT="${PKG_BASE}/rslt"
mkdir -p "${PKG_RSLT}"

rm -f "${PKG_RSLT}/Manual_${PKG_ARCH}.tgz"
tar -zcf "${PKG_RSLT}/Manual_${PKG_ARCH}.tgz" *

rm -rf "${PKG_RSLT}/CydiaInstaller.bundle"
mkdir "${PKG_RSLT}/CydiaInstaller.bundle"

mkdir "${PKG_RSLT}/CydiaInstaller.bundle/files"
cp -a * "${PKG_RSLT}/CydiaInstaller.bundle/files"

{
    cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Name</key>
    <string>Cydia Installer</string>
    <key>Identifier</key>
    <string>org.saurik.cydia</string>
    <key>Description</key>
    <string>/Working/ set of Unix tools and frameworks.</string>
    <key>SupportedFirmware</key>
    <array>
        <string>iPod1,1_2.0_5A240d</string>
        <string>iPod1,1_2.0_5A225c</string>
        <string>iPhone1,1_1.2.0_5A147p</string>
        <string>iPhone1,1_1.2.0_5A225c</string>
        <string>iPhone1,1_2.0_5A240d</string>
        <string>iPhone1,1_2.0_5A274d</string>
        <string>iPhone1,1_2.0_5A308</string>
        <string>iPhone1,1_2.0_5A311</string>
    </array>
    <key>Commands</key>
    <array>
EOF

    find \( -not -uid 0 -o -not -gid 0 \) -printf '%U %G %p\n' | while IFS= read -r line; do
        set ${line}

        cat <<EOF
        <dict>
            <key>Action</key>
            <string>SetOwner</string>
            <key>File</key>
            <string>${3#./}</string>
            <key>Owner</key>
            <string>$1:$2</string>
        </dict>
EOF
    done

    find -perm /6000 -printf '%m %p\n' | while IFS= read -r line; do
        set ${line}

        cat <<EOF
        <dict>
            <key>Action</key>
            <string>SetPermission</string>
            <key>File</key>
            <string>${2#./}</string>
            <key>Permission</key>
            <string>$1</string>
        </dict>
EOF
    done

    cat <<EOF
    </array>
    <key>Size</key>
    <integer>$(du -bs "${PKG_RSLT}/CydiaInstaller.bundle/files" | cut -d $'\t' -f 1)</integer>
</dict>
</plist>
EOF
} >"${PKG_RSLT}/CydiaInstaller.bundle/Info.plist"

tar -zcf "${PKG_RSLT}/Pwnage_${PKG_ARCH}.tgz" -C "${PKG_RSLT}" CydiaInstaller.bundle

rm -f "${PKG_RSLT}/Manual_${PKG_ARCH}.zip"
zip -qry "${PKG_RSLT}/Manual_${PKG_ARCH}.zip" *

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

rm -f "${PKG_RSLT}/AppTapp_${PKG_ARCH}.xml"
find * -type l -print -o -name "terminfo" -prune | while read -r link; do
    echo "<array><string>Exec</string><string>/usr/libexec/cydia_/symlink $(readlink "${link}") /${link}</string></array>"
    rm -f "${link}"
done >"${PKG_RSLT}/AppTapp_${PKG_ARCH}.xml"

rm -f "${PKG_RSLT}/AppTapp_${PKG_ARCH}.zip"
zip -qry "${PKG_RSLT}/AppTapp_${PKG_ARCH}.zip" *

rm -rf "${PKG_BOOT}"
