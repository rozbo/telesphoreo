pkg:setup
CC=${PKG_TARG}-gcc pkg:configure
make
pkg:install
