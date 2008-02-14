tar -zxvf "${PKG_DATA}/javasqlite-20071108.tar.gz"
cd javasqlite-20071108
pkg:patch
autoconf
pkg:configure --with-sqlite="${PKG_ROOT}/usr" --with-sqlite3="${PKG_ROOT}/usr"
JAVAC_FLAGS='-source 1.5 -target 1.5' make
pkg:install
