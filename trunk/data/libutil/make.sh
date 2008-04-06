pkg:extract
cd *
pkg:patch
make CC="${PKG_TARG}-gcc"
make install STRIP="${PKG_TARG}-strip" DSTROOT="${PKG_DEST}"
