tar -zxvf "${PKG_DATA}/nano-2.0.7.tar.gz"
cd nano-2.0.7
pkg:configure
make
pkg:install
