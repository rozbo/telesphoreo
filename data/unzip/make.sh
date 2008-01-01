tar -zxvf "${PKG_DATA}/unzip552.tar.gz"
cd unzip-5.52
cp unix/Makefile .
make unzips CC=arm-apple-darwin-gcc CF='-O3 -Wall -I. -DBSD -DUNIX' LF2=
pkg:usrbin unzip funzip unzipsfx
