tar -zxvf "${PKG_DATA}/bzip2-1.0.4.tar.gz"
cd bzip2-1.0.4
make bzip2 bzip2recover CC=arm-apple-darwin-gcc
pkg: mkdir -p /bin
pkg: cp -a bzip2 bzip2recover /bin
