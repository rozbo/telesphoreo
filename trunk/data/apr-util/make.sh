tar -zxvf "${PKG_DATA}/apr-util-1.2.12.tar.gz"
cd apr-util-1.2.12
pkg:configure --disable-static --with-apr="$(PKG_WORK_ apr)/apr-1.2.12" --with-berkeley-db="${PKG_ROOT}"
make
pkg:install
