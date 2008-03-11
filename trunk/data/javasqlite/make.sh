pkg:extract
cd *
pkg:patch
autoconf
pkg:configure --with-sqlite="${PKG_ROOT}/usr" --with-sqlite3="${PKG_ROOT}/usr"
JAVAC_FLAGS='-source 1.5 -target 1.5' make
pkg:install
