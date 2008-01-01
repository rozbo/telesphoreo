tar -zxvf "${PKG_DATA}/sed-4.1.5.tar.gz"
cd sed-4.1.5
pkg:patch
pkg:configure
make
pkg:install
pkg:bin sed
