if [[ ! -e ${PKG_BASE}/arch/${PKG_ARCH}/target ]]; then
    echo "unknown architecture: ${PKG_ARCH}" 1>&2
    exit 1
fi

export PKG_TARG=$(cat "${PKG_BASE}/arch/${PKG_ARCH}/target")
