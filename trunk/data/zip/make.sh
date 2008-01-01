unzip "${PKG_DATA}/zip232.zip" -d zip-2.32
cd zip-2.32
cp unix/Makefile .
make zips CC=arm-apple-darwin-gcc CPP='arm-apple-darwin-gcc -E'
pkg:usrbin zip zipcloak zipnote zipsplit
