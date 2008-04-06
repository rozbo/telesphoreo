pkg:extract
cd *
pkg:patch
make CC=${PKG_TARG}-gcc PREFIX=/usr/local
pkg:install
