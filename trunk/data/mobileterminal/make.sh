pkg:extract
cd *
pkg:patch
make CC="${PKG_TARG}-gcc" package
pkg: mkdir -p /Applications
pkg: cp -a Terminal.app /Applications
