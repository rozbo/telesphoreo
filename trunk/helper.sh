#!/bin/bash

export PKG_ROOT=$(arm-apple-darwin-gcc -dumpspecs | grep '%{isysroot' | sed -e 's/.*%{isysroot\*:\([^}]*\)}.*/\1/; s/;:/\n/g' | sed -e 's/^-syslibroot //' | tail -n 1)

export PKG_WORK=${PKG_BASE}/work/${PKG_NAME}
export PKG_DEST=${PKG_BASE}/dest/${PKG_NAME}
export PKG_STAT=${PKG_BASE}/stat/${PKG_NAME}
export PKG_DATA=$(echo "${PKG_BASE}"/data/"${PKG_NAME}"?(_))
export PKG_VRSN=$(cat "${PKG_DATA}/_metadata/version")
export PKG_PRIO=$(cat "${PKG_DATA}/_metadata/priority")

if [[ ! -e ${PKG_DATA} ]]; then
    echo "unknown package: ${PKG_NAME}" 1>&2
    exit 1
fi

PKG_DEPS=("${PKG_DATA}"/_metadata/*.dep)

function pkg_ {
    if [[ ${1:0:1} = / ]]; then
        echo "${PKG_DEST}$1"
    else
        echo $1
    fi
}

function pkg: {
    declare -a argv
    declare argc=$#

    for ((i=0; $i != $argc; ++i)); do
        argv[$i]=$(pkg_ $1)
        shift
    done

    "${argv[@]}"
}
