pkg:extract
cd jocstrap-*
# XXX: omg this is stupid
PKG_ROOT2=/apl/sys/ad8 make
pkg: mkdir -p /usr/include/joc /usr/lib /usr/share/java
cp -a source/joc/*.h "${PKG_DEST}"/usr/include/joc
pkg: cp -a libobjc-sig.dylib /usr/lib
pkg: cp -a libjocstrap.jnilib /usr/lib
pkg: cp -a jocstrap.jar /usr/share/java
