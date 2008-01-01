tar -zxvf "${PKG_DATA}/expat-2.0.1.tar.gz"
cd expat-2.0.1
pkg:configure
make
pkg:install
