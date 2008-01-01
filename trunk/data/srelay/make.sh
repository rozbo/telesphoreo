tar -zxvf "${PKG_DATA}/srelay-0.4.6.tar.gz"
cd srelay-0.4.6
pkg:patch
autoconf
pkg:configure
make
pkg:usrbin srelay
