pkg:extract
cd *
CFLAGS=-O0 pkg:configure --with-classpath-install-dir=/usr
make
pkg:install
pkg: rm -rf /usr/include
