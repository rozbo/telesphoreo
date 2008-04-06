pkg:extract
cd *
Xprefix="$(PKG_DEST_ openssl)/usr" pkg:configure
make
pkg:install
