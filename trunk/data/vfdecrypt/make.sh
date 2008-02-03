pkg:extract
cd *
make CC=arm-apple-darwin-gcc
pkg: mkdir -p /usr/bin
pkg: mv vfdecrypt /usr/bin
