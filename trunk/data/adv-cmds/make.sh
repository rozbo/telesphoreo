tar -zxvf "${PKG_DATA}/adv_cmds-118.tar.gz"
cd adv_cmds-118
arm-apple-darwin-gcc -o ps ps.tproj/*.c -D'__FBSDID(x)='
mkdir -p "${PKG_DEST}/usr/bin"
cp -a ps "${PKG_DEST}/usr/bin"
