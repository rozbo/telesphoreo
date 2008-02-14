tar -jxvf "${PKG_DATA}/vim-7.1.tar.bz2"
cd vim71
pkg:patch
cd src
autoconf
cd ..
STRIP=$(which arm-apple-darwin-strip) CFLAGS='-O0' ./configure --prefix=/usr --host=arm-apple-darwin --enable-gui=no --without-x vim_cv_toupper_broken=no --with-tlib=ncurses vim_cv_terminfo=yes vim_cv_tty_group=4 vim_cv_tty_mode=0620 vim_cv_getcwd_broken=no vim_cv_stat_ignores_slash=no ac_cv_sizeof_int=4 vim_cv_memmove_handles_overlap=yes
make
pkg:install
pkg: mkdir -p /etc/profile.d
pkg: cp -a %/vim.sh /etc/profile.d
