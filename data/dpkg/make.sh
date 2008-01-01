tar -zxvf "${PKG_DATA}/dpkg_1.13.25.tar.gz"
cd dpkg-1.13.25
pkg:patch
autoconf
cp -a getopt/obstack.c lib
pkg:configure --with-admindir=/var/lib/dpkg --without-start-stop-daemon --without-dselect --disable-nls --sysconfdir=/etc --disable-linker-optimisations
make
pkg:install
