pkg:setup
pkg:configure
cp -a "${PKG_DATA}"/linuxint.h raop_play
make
pkg:install
