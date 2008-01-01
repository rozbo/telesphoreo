tar -zxvf "${PKG_DATA}/whois_4.7.24.tar.gz"
cd whois-4.7.24
make CC=arm-apple-darwin-gcc
pkg:usrbin whois
