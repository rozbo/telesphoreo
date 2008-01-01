pkg:extract
cd *
pkg:configure --disable-strip --sysconfdir=/etc
make
pkg:install
