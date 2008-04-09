pkg:extract
cd jocstrap-*
make
pkg: mkdir -p /usr/lib /usr/share/java
pkg: cp -a libobjc-sig.dylib /usr/lib
pkg: cp -a libjocstrap.jnilib /usr/lib
pkg: cp -a jocstrap.jar /usr/share/java
