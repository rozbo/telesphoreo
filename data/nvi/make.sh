pkg:extract
cd nvi-1.79
pkg:patch
cd build
ac_cv_lib_termcap=no vi_cv_sys5_pty=no pkg:configure --disable-curses
make CC=arm-apple-darwin-gcc
make install prefix="${PKG_DEST}/usr" strip="$(which arm-apple-darwin-strip)"
