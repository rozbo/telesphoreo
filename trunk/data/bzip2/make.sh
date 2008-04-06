pkg:extract
cd *
make bzip2 bzip2recover CC=${PKG_TARG}-gcc
pkg: mkdir -p /bin
pkg: cp -a bzip2 bzip2recover /bin
