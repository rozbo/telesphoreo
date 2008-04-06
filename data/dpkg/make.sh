pkg:extract
cd *
pkg:patch
autoconf
cp -a getopt/obstack.[ch] lib
pkg:configure --with-admindir=/var/lib/dpkg --without-start-stop-daemon --without-dselect --disable-nls --sysconfdir=/etc --disable-linker-optimisations
make
pkg:install
