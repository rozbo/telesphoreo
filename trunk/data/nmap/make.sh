tar -jxvf "${PKG_DATA}/nmap-4.50.tar.bz2"
cd nmap-4.50
pkg:patch
autoconf
cd libdnet-stripped
autoconf
cd ..
pkg:configure --without-liblua --without-python --without-zenmap --enable-static=yes
make
pkg:install
