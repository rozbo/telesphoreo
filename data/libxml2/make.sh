pkg:extract
cd *
pkg:configure --enable-static=no --without-python
make
pkg:install
