tar -zxvf "${PKG_DATA}/gzip-1.3.12.tar.gz"
cd gzip-1.3.12
pkg:configure
make
pkg:install
pkg:bin
