pkg:setup
autoconf
cp -a getopt/obstack.[ch] lib
pkg:configure --with-admindir=/var/lib/dpkg --without-start-stop-daemon --disable-nls --sysconfdir=/etc --disable-linker-optimisations dpkg_cv_va_copy=yes
make
pkg:install
