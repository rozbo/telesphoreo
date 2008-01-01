tar -zxvf "${PKG_DATA}/readline-5.2.tar.gz"
cd readline-5.2
pkg:patch
pkg:configure
make
pkg:install
