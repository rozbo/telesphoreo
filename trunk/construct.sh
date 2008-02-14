#!/bin/bash
set -e
shopt -s extglob nullglob
PKG_BASE=$(pwd)
PKG_REPO=/dat/web/apt.saurik.com
PKG_OVER=${PKG_REPO}/indices/override.tangelo.main.gz
PKG_PKGS=${PKG_REPO}/dists/tangelo/main/binary-darwin-arm/Packages
rm -rf link
mkdir link
for package in data/!(*_); do
    PKG_NAME=$(basename "${package}")
    PKG_DATA="${PKG_BASE}/data/${PKG_NAME}"
    echo "${PKG_NAME}" "$(cat "${PKG_DATA}/_metadata/priority")" "$(cat "${PKG_DATA}/_metadata/section")"
    ln -s "../debs/${PKG_NAME}_$(cat "${PKG_DATA}/_metadata/version")-$(cat "${PKG_BASE}/stat/${PKG_NAME}/dest-ver")_darwin-arm.deb" link
done | gzip -9c >"${PKG_OVER}"
dpkg-scanpackages link <(zcat "${PKG_OVER}") | sed -e 's/: link\//: debs\//' >"${PKG_PKGS}"
gzip -c "${PKG_PKGS}" >"${PKG_PKGS}.gz"
#rm -rf "${PKG_REPO}/debs"
#cp -a debs "${PKG_REPO}"
cd "${PKG_REPO}/dists/tangelo"

export PKG_RVSN=90

cat >main/binary-darwin-arm/Release <<EOF
Archive: stable
Version: 1.0r${PKG_RVSN}
Component: main
Origin: Jay Freeman (saurik)
Label: Telesphoreo
Architecture: darwin-arm
EOF

{
    cat <<EOF
Origin: Jay Freeman (saurik)
Label: Telesphoreo
Suite: stable
Version: 1.0r${PKG_RVSN}
Codename: tangelo
Architectures: darwin-arm
Components: main
Description: Telesphoreo Tangelo 1.0r${PKG_RVSN}
MD5Sum:
EOF

    find */* -type f | while read -r line; do
        echo " $(md5sum "${line}" | cut -d ' ' -f 1) $(du -b "${line}" | cut -d $'\t' -f 1) ${line}"
    done

} >"Release"

rm -f Release.gpg
gpg -abs -o Release.gpg Release
