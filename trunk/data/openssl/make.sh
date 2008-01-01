tar -zxvf "${PKG_DATA}/openssl-0.9.8g.tar.gz"
cd openssl-0.9.8g
pkg:patch
./Configure darwin-arm-gcc --prefix=/usr --openssldir=/usr/lib/ssl shared
make AR='arm-apple-darwin-ar -r'
make install INSTALL_PREFIX="${PKG_DEST}"
rm -rf "${PKG_DEST}"/usr/lib/man
mkdir -p "${PKG_DEST}"/etc/ssl
mv "${PKG_DEST}"/usr/lib/ssl/{certs,openssl.cnf,private} "${PKG_DEST}"/etc/ssl
ln -s /etc/ssl/{certs,openssl.cnf,private} "${PKG_DEST}"/usr/lib/ssl
