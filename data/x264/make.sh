pkg:setup
CC=${PKG_TARG}-gcc pkg:configure --enable-shared
make
pkg:install
