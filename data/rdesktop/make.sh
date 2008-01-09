pkg:extract
cd *
pkg:configure --with-openssl="${PKG_ROOT}/usr"
make
pkg:install
