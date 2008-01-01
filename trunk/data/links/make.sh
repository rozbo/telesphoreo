tar -zxvf "${PKG_DATA}/links-0.99.tar.gz"
cd links-0.99
pkg:configure
make
pkg:install
