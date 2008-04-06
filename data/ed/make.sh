pkg:extract
cd *
./configure --prefix=/usr
make CC="${PKG_TARG}-gcc"
pkg:install
