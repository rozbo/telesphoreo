pkg:setup
pkg:configure
make
pkg:install
pkg:bin tar
pkg: mkdir -p /usr/bin
ln -s /bin/tar "${PKG_DEST}/usr/bin/tar"
