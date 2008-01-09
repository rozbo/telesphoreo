tar -zxvf "${PKG_DATA}/db-4.6.21.tar.gz"
cd db-4.6.21/build_unix
PKG_CONF=../dist/configure pkg:configure
make
pkg:install
