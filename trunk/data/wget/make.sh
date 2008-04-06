pkg:extract
cd *
pkg:patch
pkg:configure --with-libssl-prefix="$(PKG_DEST_ openssl)"
make
pkg:install
