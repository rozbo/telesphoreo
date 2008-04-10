pkg:extract
cd *
pkg: mkdir -p /usr/lib
cp -a *.o "${PKG_DEST}"/usr/lib
