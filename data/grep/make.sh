pkg:extract
cd *
pkg:patch
pkg:configure --disable-perl-regexp --bindir=/bin
make
pkg:install
