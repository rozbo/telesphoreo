tar -zxvf "${PKG_DATA}/less-416.tar.gz"
cd less-416
pkg:configure
make
pkg:install
