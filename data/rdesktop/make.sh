pkg:extract
cd *
pkg:patch
pkg:configure --with-openssl="${PKG_ROOT}/usr"
make
pkg:install
