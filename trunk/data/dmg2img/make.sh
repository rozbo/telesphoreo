pkg:extract
cd *
pkg:patch
make CC=arm-apple-darwin-gcc
pkg: mkdir -p /usr/bin
pkg: mv dmg2img /usr/bin
