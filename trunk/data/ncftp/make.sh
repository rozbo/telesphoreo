tar -zxvf "${PKG_DATA}/ncftp-3.2.1-src.tar.gz"
cd ncftp-3.2.1
CC=$(which arm-apple-darwin-gcc) ./configure --prefix=/usr
make
mkdir -p "${PKG_DEST}/usr/share"
pkg:install
