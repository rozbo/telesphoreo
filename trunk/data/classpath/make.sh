tar -zxvf "${PKG_DATA}/classpath-0.96.1.tar.gz"
cd classpath-0.96.1
pkg:configure --disable-examples --disable-gconf-peer --disable-gtk-peer --disable-plugin
make
pkg:install
