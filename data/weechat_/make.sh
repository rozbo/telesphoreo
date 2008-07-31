pkg:setup
autoconf
pkg:configure --with-libiconv-prefix="${PKG_ROOT}" --disable-gnutls --disable-python --disable-ruby
make
pkg:install
