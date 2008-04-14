pkg:setup
pkg:configure --with-shared --without-normal --without-debug
make
pkg:install
