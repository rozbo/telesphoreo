pkg:extract
cd *
pkg:patch
CC=$(which arm-apple-darwin-gcc) ./configure --prefix=/usr
make
mkdir -p "${PKG_DEST}/usr/share"
pkg:install
