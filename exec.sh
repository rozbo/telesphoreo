#!/bin/bash
set -e
shopt -s extglob nullglob

export PKG_NAME=${1%_}
export PKG_BASE=$(realpath "$(dirname "$0")")
export PATH=${PKG_BASE}/util:$PATH
shift

source "${PKG_BASE}/helper.sh"

PKG_PATH=

PKG_INCL=
PKG_LIBS=
PKG_PKGS=

for dep in $(find -L "${PKG_DATA}"/_metadata -name '*.dep' | cut -d '/' -f - | sort -u); do
    DEP_NAME=$(basename "${dep}" .dep)
    DEP_DEST=$(PKG_DEST_ "${DEP_NAME}")
    PKG_PATH=${PKG_PATH}:${DEP_DEST}

    if [[ -d ${DEP_DEST}/usr/include ]]; then
        PKG_INCL=${DEP_DEST}/usr/include:${PKG_INCL}
    fi

    if [[ -d ${DEP_DEST}/usr/lib ]]; then
        PKG_LIBS=${DEP_DEST}/usr/lib:${PKG_LIBS}
    fi

    if [[ -d ${DEP_DEST}/usr/lib/pkgconfig ]]; then
        PKG_PKGS=${DEP_DEST}/usr/lib/pkgconfig:${PKG_PKGS}
    fi
done

PKG_PATH=${PKG_PATH}:${PKG_ROOT}
export PKG_PATH=${PKG_PATH#:}

PKG_INCL=${PKG_INCL%:}
PKG_LIBS=${PKG_LIBS%:}
PKG_PKGS=${PKG_PKGS%:}

C_INCLUDE_PATH= \
COMPILER_PATH=${PKG_BASE}/util \
CPATH=${PKG_INCL} \
CPLUS_INCLUDE_PATH= \
GCC_EXEC_PREFIX=${PKG_PFIX}/lib/gcc \
LD_LIBRARY_PATH=${PKG_LIBS} \
LIBRARY_PATH=${PKG_LIBS} \
PKG_CONFIG_PATH=${PKG_PKGS} \
    "$@"
