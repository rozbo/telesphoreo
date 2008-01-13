pkg:extract
cd *
CFLAGS=-O0 pkg:configure --with-classpath-install-dir=/usr --disable-ffi
make
pkg:install
pkg: rm -rf /usr/include
pkg: ln -s jamvm /usr/bin/java
