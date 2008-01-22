pkg:extract
cd *
pkg:patch
./Configure darwin-arm-gcc --prefix=/usr --openssldir=/usr/lib/ssl shared
make AR='arm-apple-darwin-ar -r'
make install INSTALL_PREFIX="${PKG_DEST}"
pkg: rm -rf /usr/lib/man /usr/lib/ssl/man
pkg: mkdir -p /etc/ssl
mv "${PKG_DEST}"/usr/lib/ssl/{certs,openssl.cnf,private} "${PKG_DEST}"/etc/ssl
ln -s /etc/ssl/{certs,openssl.cnf,private} "${PKG_DEST}"/usr/lib/ssl
