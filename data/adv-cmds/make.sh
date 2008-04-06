pkg:extract
cd *
for tproj in finger fingerd last lsvfs md ps; do
    "${PKG_TARG}-gcc" -o "${tproj}" "${tproj}.tproj"/*.c -D'__FBSDID(x)='
done
pkg: mkdir -p /bin /usr/bin /usr/libexec
pkg: cp -a ps /bin
pkg: cp -a finger last lsvfs md /usr/bin
pkg: cp -a fingerd /usr/libexec
