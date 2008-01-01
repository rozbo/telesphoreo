pkg:extract
cd gcc/libffi
pkg:patch
cd ../..
mkdir build
cd build
PKG_CONF=../gcc/libffi/configure
pkg:configure --with-sysroot="${PKG_ROOT}"
make
pkg:install
pkg: mv /usr/lib/gcc/arm-apple-darwin/include /usr/
pkg: rm -rfv /usr/lib/gcc
