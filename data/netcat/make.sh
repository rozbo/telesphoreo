tar -zxvf "${PKG_DATA}/netcat-0.7.1.tar.gz"
cd netcat-0.7.1
pkg:configure
make
pkg:install
pkg:bin
