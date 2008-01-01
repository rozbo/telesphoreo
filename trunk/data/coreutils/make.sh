tar -zxvf "${PKG_DATA}/coreutils-6.9.tar.gz"
cd coreutils-6.9
./configure --prefix=/usr --host=arm-apple-darwin
make
pkg:install
pkg:bin cat chgrp chmod chown cp date dd df dir echo false hostname kill ln ls mkdir mknod mv pwd readlink rm rmdir vdir sleep stty su sync touch true uname
