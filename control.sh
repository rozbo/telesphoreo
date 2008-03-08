#!/bin/bash
shopt -s extglob nullglob

export PKG_NAME=$1
shift

export PKG_BASE=$(realpath "$(dirname "$0")")
. "${PKG_BASE}/helper.sh"

if [[ -n $2 ]]; then
    PKG_VRSN=$2
fi

cat <<EOF
Package: ${PKG_NAME}
EOF

if [[ ${PKG_PRIO} == required || ${PKG_PRIO} == +* ]]; then
    cat <<EOF
Essential: yes
EOF
fi

if [[ $1 == status ]]; then
    cat <<EOF
Status: install ok installed
EOF
fi

cat <<EOF
Priority: ${PKG_PRIO#+}
Section: $(cat "${PKG_DATA}/_metadata/section")
EOF

if [[ $1 == status || $1 == available ]]; then
    cat <<EOF
Installed-Size: $(dpkg -f "${PKG_BASE}/debs/${PKG_NAME}_${PKG_VRSN}-${PKG_RVSN}_darwin-arm.deb" Installed-Size)
EOF
elif [[ $1 == control ]]; then
    cat <<EOF
Installed-Size: $(du -s "${PKG_DEST}" | cut -d $'\t' -f 1)
EOF
fi

cat <<EOF
Maintainer: $(cat "${PKG_DATA}/_metadata/maintainer")
Architecture: darwin-arm
EOF

echo -n "Version: ${PKG_VRSN}"

if [[ $1 == status || $1 == available ]]; then
    echo "-${PKG_RVSN}"
else
    echo
fi

if [[ $1 == available ]]; then
    cat <<EOF
Size: $(find "${PKG_DEST}" -type f -exec cat {} \; | gzip -c | wc -c | cut -d $'\t' -f 1)
EOF
fi

unset comma
for dep in "${PKG_DEPS[@]}"; do
    if [[ ${comma+@} == @ ]]; then
        echo -n ","
    else
        echo -n "Depends:"
        comma=
    fi

    echo -n " $(basename "${dep}" .dep)"
done

if [[ ${comma+@} == @ ]]; then
    echo
fi

cat <<EOF
Description: $(head -n 1 "${PKG_DATA}/_metadata/description")
EOF

if [[ $(wc -l "${PKG_DATA}/_metadata/description" | cut -d ' ' -f 1) -gt 1 ]]; then
    cat <<EOF
$(tail -n +2 "${PKG_DATA}/_metadata/description" | fold -sw 72 | sed -e 's/^/ /')
EOF
fi

if [[ -e ${PKG_DATA}/_metadata/name ]]; then
    cat <<EOF
Name: $(cat "${PKG_DATA}/_metadata/name")
EOF
fi

if [[ -e ${PKG_DATA}/_metadata/website ]]; then
    cat <<EOF
Website: $(cat "${PKG_DATA}/_metadata/website")
EOF
fi

if [[ $1 == status || $1 == available ]]; then
    echo
fi
