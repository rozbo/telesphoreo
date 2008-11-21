pkg:setup
autoconf
cd libdnet-stripped
autoconf
cd ..
pkg:configure --without-liblua --without-python --without-zenmap --enable-static=yes --with-liblua=no
make
pkg:install
