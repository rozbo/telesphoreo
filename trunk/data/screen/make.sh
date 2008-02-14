pkg:extract
cd *
pkg:patch
autoconf
pkg:configure --disable-pam --with-sys-screenrc=/etc/screenrc
make
pkg:install
pkg: mkdir -p /etc
pkg: cp -a etc/etcscreenrc /etc/screenrc
