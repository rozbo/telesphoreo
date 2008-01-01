tar -zxvf "${PKG_DATA}/top-37.tar.gz"
cd top-37
pkg:patch
make CC=arm-apple-darwin-gcc AR=arm-apple-darwin-ar RANLIB=arm-apple-darwin-ranlib
make install STRIP=arm-apple-darwin-strip DSTROOT="${PKG_DEST}"
