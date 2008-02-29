tar -zxvf "${PKG_DATA}/coreutils-6.9.tar.gz"
cd coreutils-6.9
./configure --prefix=/usr --host=arm-apple-darwin
make
pkg:install
pkg: rm -f /usr/bin/sync
pkg:bin cat chgrp chmod chown cp date dd df dir echo false hostname kill ln ls mkdir mknod mv pwd readlink rm rmdir vdir sleep stty su touch true uname
pkg: mkdir -p /usr/sbin
pkg: mv /usr/bin/chroot /usr/sbin
pkg: mkdir -p /etc/profile.d
pkg: cp -a %/coreutils.sh /etc/profile.d
pkg: cp -a /bin/chown /usr/bin/chown
pkg: cp -a /bin/chown /usr/sbin/chown
