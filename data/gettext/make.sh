pkg:setup
pkg:configure --disable-java --without-libintl-prefix
pkg:make
pkg:install
pkg: rm -rf /usr/share
