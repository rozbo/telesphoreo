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
export PATH=${PKG_BASE}/util:$PATH
. "${PKG_BASE}/helper.sh"

for dep in "${PKG_DEPS[@]}"; do
    "${PKG_MAKE}" "$(basename "${dep}" .dep)"
done

export PKG_HASH=$({
    find -L "${PKG_DATA}" \( -name '.svn' -o -name '_*' \) -prune -o -type f -print0 | sort -z | xargs -0 cat
    for dep in "${PKG_DEPS[@]}"; do
        DEP_NAME=$(basename "${dep}" .dep)
        DEP_DEST=${PKG_BASE}/dest/${DEP_NAME}
        "${PKG_BASE}"/util/catdir.sh "${DEP_DEST}"
    done
} | md5sum | cut -d ' ' -f 1)

echo "hashed data ${PKG_NAME} to: ${PKG_HASH}"

if [[ -e "${PKG_STAT}/data-md5" && ${PKG_HASH} == $(cat "${PKG_STAT}/data-md5") ]]; then
    echo "skipping re-build of ${PKG_NAME}"
    exit
fi

mkdir -p "${PKG_STAT}"
rm -f "${PKG_STAT}/data-md5"

rm -rf "${PKG_DEST}"
mkdir "${PKG_DEST}"

rm -rf "${PKG_WORK}"
mkdir "${PKG_WORK}"

function PKG_DATA_() {
    echo "${PKG_BASE}/data/$1"
}

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
    for ltmain in $(find -name ltmain.sh); do
        patch "${ltmain}" "${PKG_BASE}/util/libtool.diff" || true
    done

    PKG_CONFIG="$(realpath "${PKG_BASE}/util/pkg-config.sh") --define-variable=prefix=${PKG_ROOT}/usr" \
    PKG_CONFIG_PATH=${PKG_ROOT}/usr/lib/pkgconfig \
    "${PKG_CONF}" \
        --host=arm-apple-darwin \
        --enable-static=no \
        --enable-shared=yes \
        --prefix=/usr \
        --localstatedir="/var/cache/${PKG_NAME}" \
        "$@"
}

function pkg:install() {
    make install DESTDIR="${PKG_DEST}" "$@"
}

function pkg_ {
    case "${1:0:1}" in
        (/) echo "${PKG_DEST}$1";;
        (%) echo "${PKG_DATA}${1:1}";;
        (*) echo -"$1" | sed -e 's/^.//';;
    esac
}

function pkg: {
    declare -a argv
    declare argc=$#

    for ((i=0; $i != $argc; ++i)); do
        argv[$i]=$(pkg_ "$1")
        shift
    done

    "${argv[@]}"
}

function pkg:extract() {
    for tgz in "${PKG_DATA}"/{*.tar.gz,*.tgz}; do
        tar -zxvf "${tgz}"
    done
    for zip in "${PKG_DATA}"/*.zip; do
        unzip "${zip}"
    done
    for tbz2 in "${PKG_DATA}"/*.tar.bz2; do
        tar -jxvf "${tbz2}"
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

rm -rf "${PKG_DEST}/usr/share/locale"
rm -rf "${PKG_DEST}/usr/share/man"
rm -rf "${PKG_DEST}/usr/share/info"
rm -rf "${PKG_DEST}/usr/share/gtk-doc"
rm -rf "${PKG_DEST}/usr/share/doc"
rm -rf "${PKG_DEST}/usr/man"
rm -rf "${PKG_DEST}/usr/local/share/man"
rm -rf "${PKG_DEST}/usr/local/OpenSourceVersions"
rm -rf "${PKG_DEST}/usr/local/OpenSourceLicenses"
rm -f "${PKG_DEST}/usr/lib/charset.alias"
rm -rf "${PKG_DEST}/usr/info"
rm -rf "${PKG_DEST}/usr/docs"
rm -rf "${PKG_DEST}/usr/doc"

rmdir_ "${PKG_DEST}/usr/share"
rmdir_ "${PKG_DEST}/usr/local/share"
rmdir_ "${PKG_DEST}/usr/local"
rmdir_ "${PKG_DEST}/usr/lib"
rmdir_ "${PKG_DEST}/usr"

if [[ -e "${PKG_DEST}"{/usr,}/?(s)bin ]]; then
    find "${PKG_DEST}"{/usr,}/?(s)bin -type f -exec arm-apple-darwin-strip {} \;
fi

cp -a "${PKG_DATA}/_metadata/version" "${PKG_STAT}/data-ver"
echo "${PKG_HASH}" >"${PKG_STAT}/data-md5"
