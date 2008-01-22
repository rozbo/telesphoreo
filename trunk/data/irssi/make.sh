pkg:extract
cd *
CFLAGS=-O0 pkg:configure --enable-static
make
pkg:install
