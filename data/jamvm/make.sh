tar -zxvf "${PKG_DATA}/jamvm-1.5.1b2.tar.gz"
cd jamvm-1.5.1
CFLAGS=-O0 pkg:configure --with-classpath-install-dir=/usr
make
pkg:install
