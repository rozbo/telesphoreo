pkg:extract
cd *
pkg:patch
pkg:autoconf
pkg:configure --enable-static
make
pkg:install
