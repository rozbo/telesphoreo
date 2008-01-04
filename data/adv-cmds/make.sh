pkg:extract
cd *
for tproj in lsvfs ps; do
    arm-apple-darwin-gcc -o "${tproj}" "${tproj}.tproj"/*.c -D'__FBSDID(x)='
    arm-apple-darwin-strip "${tproj}"
done
pkg: mkdir -p /bin /usr/bin
pkg: cp -a ps /bin
pkg: cp -a lsvfs /usr/bin
