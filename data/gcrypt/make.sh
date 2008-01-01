pkg:extract
cd *
pkg:patch
pkg:configure --enable-static=no
make
pkg:install
