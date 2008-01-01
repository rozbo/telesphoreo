pkg:extract
cd *
autoconf
pkg:configure
make
make install prefix="${PKG_DEST}/usr"
