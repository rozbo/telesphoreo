tar -zxvf "${PKG_DATA}/findutils-4.2.31.tar.gz"
cd findutils-4.2.31
pkg:configure
make
pkg:install
