pkg:extract
cd *
pkg:configure --enable-static=no
make
pkg:install
rm -f "${PKG_DEST}"/usr/lib/libsqlite3*.dylib
