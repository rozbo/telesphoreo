pkg:setup
make CC="${PKG_TARG}-gcc" package
pkg: mkdir -p /Applications
pkg: cp -a Terminal.app /Applications
