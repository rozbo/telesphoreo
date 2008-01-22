tar -zxvf "${PKG_DATA}/shell_cmds-116.tar.gz"
cd shell_cmds-116
mkdir -p "${PKG_DEST}/usr/bin"
for bin in killall mktemp renice script time which; do
    arm-apple-darwin-gcc -o "${bin}/${bin}" "${bin}"/*.c -D'__FBSDID(x)='
    cp -a "${bin}/${bin}" "${PKG_DEST}/usr/bin"
done
pkg:bin mktemp
