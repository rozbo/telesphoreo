pkg:extract
cd *
pkg:patch
CC=arm-apple-darwin-gcc pkg:configure
make
pkg:install
