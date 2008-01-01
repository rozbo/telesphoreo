tar -zxvf "${PKG_DATA}/unrarsrc-3.6.8.tar.gz"
cd unrar
pkg:patch
make -f makefile.unix CXX=arm-apple-darwin-g++ STRIP=arm-apple-darwin-strip all
pkg:usrbin unrar
