pkg:setup
pkg:configure --with-openssl="${PKG_ROOT}/usr"
make
pkg:install
