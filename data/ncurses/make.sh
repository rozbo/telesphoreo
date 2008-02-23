pkg:extract
cd *
pkg:patch
pkg:configure --with-shared --without-normal --without-debug
make
pkg:install
