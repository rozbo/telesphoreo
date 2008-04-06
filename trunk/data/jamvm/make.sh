pkg:extract
cd *
pkg:patch
#PKG_CONF=./autogen.sh
pkg:configure --with-classpath-install-dir=/usr --enable-ffi=no
make with_classpath_install_dir="$(PKG_DEST_ classpath)/usr"
pkg:install
pkg: rm -rf /usr/include
pkg: ln -s jamvm /usr/bin/java
