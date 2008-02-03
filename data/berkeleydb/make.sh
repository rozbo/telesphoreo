pkg:extract
cd *
cd build_unix
PKG_CONF=../dist/configure pkg:configure
make
pkg:install
