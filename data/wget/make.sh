tar -zxvf "${PKG_DATA}/wget-1.9.1.tar.gz"
cd wget-1.9.1
pkg:configure
make
pkg:install
