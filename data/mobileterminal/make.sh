pkg:setup
echo "#define SVN_VERSION @\"${PKG_VERS}\"" >svnversion.h
make clean
make -f Makefile.build CC="${PKG_TARG}-gcc"
pkg: mkdir -p /Applications/Terminal.app
pkg: cp -a Info.plist Resources/* Terminal /Applications/Terminal.app
