tar -zxvf "${PKG_DATA}/neon-0.26.4.tar.gz"
cd neon-0.26.4
pkg:patch
autoconf
pkg:configure --with-ssl
#--with-expat="${PKG_ROOT}/usr/lib/libexpat.la"
make
pkg:install
