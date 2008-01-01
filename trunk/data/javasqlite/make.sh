tar -zxvf "${PKG_DATA}/javasqlite-20071108.tar.gz"
cd javasqlite-20071108
pkg:patch
autoconf
pkg:configure --with-sqlite="${PKG_ROOT}/usr" --with-sqlite3="${PKG_ROOT}/usr"
make
pkg:install
