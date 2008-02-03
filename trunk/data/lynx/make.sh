pkg:extract
cd *
pkg:patch
pkg:configure --with-screen=ncurses --with-ssl
make
pkg:install
