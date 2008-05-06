#!/bin/bash
set -e
shopt -s extglob nullglob

PKG_BASE=$(dirname "$(realpath "$0")")
cd "${PKG_BASE}"
PKG_RVSN=266

PKG_REPO=/dat/web/apt.saurik.com
PKG_OVER=${PKG_REPO}/indices/override.tangelo.main.gz

for PKG_ARCH in "${PKG_BASE}/arch"/*; do
    PKG_ARCH=$(basename "${PKG_ARCH}")
    echo "scanning ${PKG_ARCH}"

    PKG_PKGS=${PKG_REPO}/dists/tangelo/main/binary-${PKG_ARCH}/Packages

    rm -rf "${PKG_BASE}/link"
    mkdir "${PKG_BASE}/link"
    for package in "${PKG_BASE}/data"/!(*_); do
        PKG_NAME=$(basename "${package}")
        PKG_DATA="${PKG_BASE}/data/${PKG_NAME}"
        PKG_PRIO=$(cat "${PKG_DATA}/_metadata/priority")
        echo "${PKG_NAME}" "${PKG_PRIO#+}" "$(cat "${PKG_DATA}/_metadata/section")"

        PKG_FILE=${PKG_BASE}/stat/${PKG_ARCH}/${PKG_NAME}/dest-ver
        if [[ -e ${PKG_FILE} ]]; then
            PKG_FILE=${PKG_BASE}/debs/${PKG_NAME}_$(cat "${PKG_DATA}/_metadata/version")-$(cat "${PKG_FILE}")_${PKG_ARCH}.deb
            if [[ -e ${PKG_FILE} ]]; then
                ln -s "${PKG_FILE}" "${PKG_BASE}/link"
                echo "${PKG_FILE}"
            fi
        fi
    done >"${PKG_BASE}/overrides.txt"

    dpkg-scanpackages link "${PKG_BASE}/overrides.txt" | sed -e 's/: link\//: debs\//' >"${PKG_PKGS}"
    rm -f "${PKG_BASE}/overrides.txt"

    gzip -c "${PKG_PKGS}" >"${PKG_PKGS}.gz"
done

cd "${PKG_REPO}/dists/tangelo"

{
    cat <<EOF
Origin: Jay Freeman (saurik)
Label: Telesphoreo
Suite: stable
Version: 1.0r${PKG_RVSN}
Codename: tangelo
Architectures:$(for PKG_ARCH in "${PKG_BASE}/arch"/*; do echo -n " $(basename "${PKG_ARCH}")"; done)
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
