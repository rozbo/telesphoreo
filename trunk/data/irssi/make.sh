pkg:extract
cd *
pkg:patch
CFLAGS=-O0 pkg:configure --enable-static
make
pkg:install
