#!/bin/bash
set -e
shopt -s extglob nullglob

if [[ $# == 0 ]]; then
    echo "usage: $0 <package>"
    exit
fi

export PKG_MAKE=$0
export PKG_NAME=${1%_}

export PKG_BASE=$(realpath "$(dirname "$0")")
source "${PKG_BASE}/helper.sh"

./make.sh "${PKG_NAME}"

pkg: mkdir -p /DEBIAN
./control.sh "${PKG_NAME}" control >"$(pkg_ /DEBIAN/control)"

if [[ -e "${PKG_DATA}"/_metadata/preinst ]]; then
    cp -a "${PKG_DATA}"/_metadata/preinst "$(pkg_ /DEBIAN)"
fi

if [[ -e "${PKG_DATA}"/_metadata/postinst ]]; then
    cp -a "${PKG_DATA}"/_metadata/postinst "$(pkg_ /DEBIAN)"
fi

if [[ -e "${PKG_DATA}"/_metadata/prerm ]]; then
    cp -a "${PKG_DATA}"/_metadata/prerm "$(pkg_ /DEBIAN)"
fi

#if [[ -e "${PKG_DATA}"/_metadata/conffiles ]]; then
#    cp -a "${PKG_DATA}"/_metadata/conffiles "$(pkg_ /DEBIAN)"
#fi

export PKG_HASH=$(util/catdir.sh "${PKG_DEST}" | md5sum | cut -d ' ' -f 1)
echo "hashed dest ${PKG_NAME} to: ${PKG_HASH}"

if [[ -e "${PKG_STAT}/dest-md5" && ${PKG_HASH} == $(cat "${PKG_STAT}/dest-md5" 2>/dev/null) ]]; then
    echo "skipping re-package of ${PKG_NAME}"
else
    if [[ -z ${PKG_RVSN} ]]; then
        PKG_RVSN=1
    else
        PKG_RVSN=$((${PKG_RVSN} + 1))
    fi

    export PKG_PACK=${PKG_BASE}/debs/${PKG_NAME}_${PKG_VRSN}-${PKG_RVSN}_${PKG_ARCH}.deb
    if [[ -e ${PKG_PACK} ]]; then
        echo "package ${PKG_PACK} already exists..."
    else
        ./control.sh "${PKG_NAME}" control "${PKG_VRSN}-${PKG_RVSN}" >"$(pkg_ /DEBIAN/control)"
        dpkg-deb -b "${PKG_DEST}" "${PKG_PACK}"
        echo "${PKG_HASH}" >"${PKG_STAT}/dest-md5"
        echo "${PKG_RVSN}" >"${PKG_STAT}/dest-ver"
    fi
fi

pkg: rm -rf /DEBIAN
