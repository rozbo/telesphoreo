tar -zxvf "${PKG_DATA}/grep-2.5.tar.gz"
cd grep-2.5
pkg:patch
pkg:configure --disable-perl-regexp
make
pkg:install
pkg:bin grep
