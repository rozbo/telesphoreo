#!/bin/bash
set -e
shopt -s extglob nullglob
PKG_REPO=/dat/web/apt.saurik.com
PKG_OVER=${PKG_REPO}/indices/override.tangelo.main.gz
PKG_PKGS=${PKG_REPO}/dists/tangelo/main/binary-darwin-arm/Packages
for package in data/!(*_); do
    PKG_NAME=$(basename "${package}")
    echo "${PKG_NAME}" "$(cat "data/${PKG_NAME}/_metadata/priority")" "$(cat "data/${PKG_NAME}/_metadata/section")"
done | gzip -9c >"${PKG_OVER}"
dpkg-scanpackages debs <(zcat "${PKG_OVER}") >"${PKG_PKGS}"
gzip -c "${PKG_PKGS}" >"${PKG_PKGS}.gz"
rm -rf "${PKG_REPO}/debs"
cp -a debs "${PKG_REPO}"
cd "${PKG_REPO}/dists/tangelo"

cat >main/binary-darwin-arm/Release <<EOF
Archive: stable
Version: 1.0r5
Component: main
Origin: saurik
Label: Telesphoreo
Architecture: darwin-arm
EOF

{
    cat <<EOF
Origin: saurik
Label: Telesphoreo
Suite: stable
Version: 1.0r5
Codename: tangelo
Architectures: darwin-arm
Components: main
Description: Telesphoreo Tangelo 1.0r5
MD5Sum:
EOF

    find */* -type f | while read -r line; do
        echo " $(md5sum "${line}" | cut -d ' ' -f 1) $(du -b "${line}" | cut -d $'\t' -f 1) ${line}"
    done

} >"Release"

rm -f Release.gpg
gpg -abs -o Release.gpg Release
