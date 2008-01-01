tar -jxvf "${PKG_DATA}/ngrep-1.45.tar.bz2"
cd ngrep-1.45
pkg:patch
autoconf
cd regex-0.12
autoconf
cd ..
pkg:configure "--with-pcap-includes=${PKG_ROOT}/usr/include"
make
pkg:install
