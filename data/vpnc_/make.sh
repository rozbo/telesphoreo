pkg:extract
cd *
pkg:patch
make CC=arm-apple-darwin-gcc PREFIX=/usr/local
pkg:install
