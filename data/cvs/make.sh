pkg:extract
cd *
pkg:configure --without-gssapi
make
pkg:install
