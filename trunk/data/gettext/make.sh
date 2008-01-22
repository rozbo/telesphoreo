pkg:extract
cd *
pkg:patch
pkg:configure --without-libintl-prefix
make
pkg:install
