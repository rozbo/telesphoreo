tar -jxvf "${PKG_DATA}/subversion-1.4.6.tar.bz2"
cd subversion-1.4.6
pkg:patch
autoconf
CFLAGS="-DSVN_NEON_0_25 -DSVN_NEON_0_26" pkg:configure --enable-maintainer-mode --disable-keychain --with-neon="${PKG_ROOT}/usr" --with-apr="$(PKG_WORK_ apr)/apr-1.2.12" --with-apr-util="$(PKG_WORK_ apr-util)/apr-util-1.2.12"
make
pkg:install
