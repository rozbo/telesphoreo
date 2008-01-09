pkg:extract
cd *
pkg:configure
make
pkg:install
rm -f "${PKG_DEST}"/usr/lib/libsqlite3*.dylib
