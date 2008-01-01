tar -zxvf "${PKG_DATA}/rsync-2.6.9.tar.gz"
cd rsync-2.6.9
pkg:configure
make
pkg:install
