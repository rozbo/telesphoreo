#!/bin/bash
set -e
shopt -s extglob nullglob

export PKG_MAKE=$0
export PKG_NAME=${1%_}

export PKG_BASE=$(realpath "$(dirname "$0")")
. "${PKG_BASE}/helper.sh"

for dep in "${PKG_DEPS[@]}"; do
    "${PKG_MAKE}" "$(basename "${dep}" .dep)"
done

export PKG_HASH=$({
    find -L "${PKG_DATA}" \( -name '.svn' -o -name '_*' \) -prune -o -type f -print -exec cat {} \;
    if [[ ${#PKG_DEPS[@]} -ne 0 ]]; then
        find -H "${PKG_DEPS[@]}" -type l -printf '%p\n%l\n' -o -type f -print -exec cat {} \;
    fi
} | md5sum | cut -d ' ' -f 1)

echo "hashed ${PKG_NAME} to: ${PKG_HASH}"

if [[ -e "${PKG_STAT}/md5" && ${PKG_HASH} == $(cat "${PKG_STAT}/md5") ]]; then
    echo "skipping re-build of ${PKG_NAME}"
    exit
fi

rm -rf "${PKG_STAT}"
mkdir "${PKG_STAT}"

rm -rf "${PKG_DEST}"
mkdir "${PKG_DEST}"

rm -rf "${PKG_WORK}"
mkdir "${PKG_WORK}"

function PKG_WORK_() {
    echo "${PKG_BASE}/work/$1"
}

function pkg:patch() {
    for diff in "${PKG_DATA}"/*.diff; do
        patch -p1 <"${diff}"
    done
}

function pkg:bin() {
    if [[ $# -eq 0 ]]; then
        pushd "${PKG_DEST}/usr/bin"
        set $(ls)
        popd
    fi

    mkdir -p "${PKG_DEST}/bin"
    for bin in "$@"; do
        mv -v "${PKG_DEST}/usr/bin/${bin}" "${PKG_DEST}/bin/${bin}"
    done

    rmdir --ignore-fail-on-non-empty -p "${PKG_DEST}/usr/bin"
}

export PKG_CONF=./configure

function pkg:configure() {
    "${PKG_CONF}" --disable-nls --prefix=/usr --host=arm-apple-darwin "$@"
}

function pkg:install() {
    make install DESTDIR="${PKG_DEST}"
}

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

function pkg:extract() {
    for tgz in "${PKG_DATA}"/{*.tar.gz,*.tgz}; do
        tar -zxvf "${tgz}"
    done
}

function pkg:owner() {
    owner=$1
    shift

    for file in "$@"; do
        chown "${owner}" "${PKG_DEST}${file}"
    done
}

function pkg:usrbin() {
    pkg: mkdir -p /usr/bin
    pkg: cp -a "$@" /usr/bin
}

function pkg:mkdir() {
    for dir in "$@"; do
        mkdir -p "${PKG_DEST}${dir}"
    done
}

cd "${PKG_WORK}"
. "${PKG_DATA}/make.sh"

function rmdir_() {
    if [[ -d "$1" ]]; then
        rmdir --ignore-fail-on-non-empty "$1"
    fi
}

rm -rf "${PKG_DEST}/usr/share/info"
rm -rf "${PKG_DEST}/usr/share/locale"
rm -rf "${PKG_DEST}/usr/share/man"
rm -rf "${PKG_DEST}/usr/share/doc"
rm -rf "${PKG_DEST}/usr/man"
rm -rf "${PKG_DEST}/usr/local/share/man"
rm -rf "${PKG_DEST}/usr/local/OpenSourceVersions"
rm -rf "${PKG_DEST}/usr/local/OpenSourceLicenses"
rm -f "${PKG_DEST}/usr/lib/charset.alias"
rm -rf "${PKG_DEST}/usr/info"
rm -rf "${PKG_DEST}/usr/docs"

rmdir_ "${PKG_DEST}/usr/share"
rmdir_ "${PKG_DEST}/usr/local/share"
rmdir_ "${PKG_DEST}/usr/local"
rmdir_ "${PKG_DEST}/usr/lib"
rmdir_ "${PKG_DEST}/usr"

echo "${PKG_HASH}" >"${PKG_STAT}/md5"