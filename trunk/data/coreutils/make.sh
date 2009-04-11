pkg:setup
pkg:configure --enable-install-program=su
make AR="${PKG_TARG}-ar" CFLAGS='-O2 -mthumb'
pkg:install
pkg: rm -f /usr/bin/sync
pkg:bin cat chgrp chmod chown cp date dd df dir echo false kill ln ls mkdir mknod mktemp mv pwd readlink rm rmdir sleep stty su touch true uname vdir
pkg: mkdir -p /usr/sbin
pkg: mv /usr/bin/chroot /usr/sbin
pkg: mkdir -p /etc/profile.d
pkg: cp -a %/coreutils.sh /etc/profile.d
ln -s /bin/chown "${PKG_DEST}"/usr/bin
ln -s /bin/chown "${PKG_DEST}"/usr/sbin
ln -s /bin/mktemp "${PKG_DEST}"/usr/bin
