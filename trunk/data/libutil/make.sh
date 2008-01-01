tar -zxvf "${PKG_DATA}/libutil-11.tar.gz"
cd libutil-11
make CC=arm-apple-darwin-gcc
make install STRIP=arm-apple-darwin-strip DSTROOT="${PKG_DEST}"
