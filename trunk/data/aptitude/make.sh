shopt -s extglob
pkg:setup
pkg:configure
make
pkg:install
rm -f "${PKG_DEST}"/usr/share/aptitude/!(aptitude-defaults)
