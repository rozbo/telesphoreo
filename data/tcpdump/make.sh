tar -zxvf "${PKG_DATA}/tcpdump-3.9.8.tar.gz"
cd tcpdump-3.9.8
Xprefix="${PKG_ROOT}/usr" pkg:configure
make
pkg:install
