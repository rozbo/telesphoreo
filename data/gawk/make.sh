tar -zxvf "${PKG_DATA}/gawk-3.1.6.tar.gz"
cd gawk-3.1.6
pkg:patch
pkg:configure
make
pkg:install
rm -f "${PKG_DEST}"/usr/bin/{pgawk*,gawk-*}
