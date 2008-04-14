pkg:setup
pkg:configure --with-pcap=bpf
make
mkdir -p "${PKG_DEST}/usr/lib"
make install-shared DESTDIR="${PKG_DEST}"
