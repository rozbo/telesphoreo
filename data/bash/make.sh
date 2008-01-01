tar -zxvf "${PKG_DATA}/bash-3.2.tar.gz"
cd bash-3.2
pkg:configure
make
pkg:install
pkg:bin bash
ln -s bash "${PKG_DEST}/bin/sh"
