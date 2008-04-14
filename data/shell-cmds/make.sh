pkg:setup
mkdir -p "${PKG_DEST}/usr/bin"
for bin in killall mktemp renice script time which; do
    ${PKG_TARG}-gcc -o "${bin}/${bin}" "${bin}"/*.c -D'__FBSDID(x)='
    cp -a "${bin}/${bin}" "${PKG_DEST}/usr/bin"
done
pkg:bin mktemp
