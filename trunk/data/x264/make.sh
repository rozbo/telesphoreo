pkg:extract
cd *
pkg:patch
CC=${PKG_TARG}-gcc pkg:configure
make
pkg:install
