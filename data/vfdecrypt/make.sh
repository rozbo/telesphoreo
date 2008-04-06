pkg:extract
cd *
pkg:patch
make CC=${PKG_TARG}-gcc
pkg: mkdir -p /usr/bin
pkg: mv vfdecrypt /usr/bin
