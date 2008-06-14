pkg:setup
autoconf
pkg:configure --with-readline-inc="$(PKG_DEST_ readline)"/usr/include/readline
make
pkg:install
