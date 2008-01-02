pkg:extract
cd *
pkg:configure --with-screen=ncurses --with-ssl
make
pkg:install
