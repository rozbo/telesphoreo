pkg:extract
cd *
pkg:patch
autoconf
pkg:configure --with-pth-prefix="${PKG_ROOT}/usr"
make
pkg:install
