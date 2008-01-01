tar -zxvf "${PKG_DATA}/make-3.81.tar.gz"
cd make-3.81
pkg:configure
make
pkg:install
