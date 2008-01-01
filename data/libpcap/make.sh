tar -zxvf "${PKG_DATA}/libpcap-0.9.8.tar.gz"
cd libpcap-0.9.8
pkg:configure --with-pcap=bpf
make
mkdir -p "${PKG_DEST}/usr/lib"
make install-shared DESTDIR="${PKG_DEST}"
