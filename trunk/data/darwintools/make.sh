pkg:setup
pkg: mkdir -p /usr/bin

for tool in startupfiletool sw_vers; do
    "${PKG_TARG}-gcc" -o "${tool}" "${tool}.c" -framework CoreFoundation
    pkg: cp -a "${tool}" /usr/bin
done
