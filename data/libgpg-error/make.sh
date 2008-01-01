pkg:extract
cd *
pkg:configure --enable-static=no
make
pkg:install
