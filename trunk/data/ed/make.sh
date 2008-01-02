pkg:extract
cd *
./configure --prefix=/usr
make CC=arm-apple-darwin-gcc
pkg:install
