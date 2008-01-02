pkg:extract
cd *
cp -a "${PKG_DATA}"/*.[ch] .
arm-apple-darwin-gcc -fno-common !(dns_async).c -o libresolv.dylib -dynamiclib -I. -DkDNSServiceFlagsReturnIntermediates=0x1000 -linfo -install_name /usr/lib/libresolv.dylib
pkg: mkdir -p /usr/lib
pkg: cp -a libresolv.dylib /usr/lib
