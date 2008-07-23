pkg:setup
pkg:configure --libdir=/usr/lib/lighttpd --with-bz2 --with-pcre
make
pkg:install
