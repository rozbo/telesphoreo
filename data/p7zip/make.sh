pkg:setup
mv -f makefile.macosx makefile.machine
make all2
make install DEST_HOME="${PKG_DEST}/usr"
