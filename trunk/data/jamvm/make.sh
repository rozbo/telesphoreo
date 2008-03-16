pkg:extract
cd *
pkg:patch
PKG_CONF=./autogen.sh
CFLAGS=-O0 pkg:configure --with-classpath-install-dir=/usr --enable-ffi=no
make
pkg:install
pkg: rm -rf /usr/include
pkg: ln -s jamvm /usr/bin/java
