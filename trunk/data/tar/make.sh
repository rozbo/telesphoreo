tar -zxvf "${PKG_DATA}/tar-1.19.tar.gz"
cd tar-1.19
pkg:patch
pkg:configure
make
pkg:install
pkg:bin tar
