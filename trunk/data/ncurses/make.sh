tar -zxvf "${PKG_DATA}/ncurses-5.6.tar.gz"
cd ncurses-5.6
pkg:configure --with-shared --without-normal --without-debug
make
pkg:install
