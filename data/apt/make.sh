tar -zxvf "${PKG_DATA}/apt_0.6.46.4-0.1.tar.gz"
cd apt-0.6.46.4.1
pkg:patch
autoconf
pkg:configure
make
pkg:mkdir /etc/apt/sources.list.d
pkg:mkdir /var/cache/apt/archives/partial
pkg:mkdir /var/lib/apt/lists/partial
pkg:mkdir /var/lib/apt/periodic
pkg: mkdir -p /usr/bin /usr/lib/apt
pkg: cp -a bin/apt-* /usr/bin
pkg: cp -a bin/libapt-* /usr/lib
pkg: cp -a bin/methods /usr/lib/apt
pkg:mkdir /usr/lib/dpkg/methods
cp -a scripts/dselect "${PKG_DEST}/usr/lib/dpkg/methods/apt"
