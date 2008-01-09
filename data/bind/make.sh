tar -zxvf "${PKG_DATA}/bind-9.4.2.tar.gz"
cd bind-9.4.2
pkg:configure --with-randomdev=/dev/random BUILD_CC=gcc
make
pkg:install
