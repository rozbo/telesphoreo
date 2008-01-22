pkg: mkdir /Applications
javac -source 1.5 -d . -cp "$(PKG_DATA_ jocstrap)/jocstrap.jar:$(PKG_WORK_ javasqlite)/javasqlite-20071108/sqlite.jar" "${PKG_DATA}/HelloJava.app/HelloJava.java"
pkg: cp -a %/Hello{Java,Script}.app /Applications
cp -a *.class "${PKG_DEST}/Applications/HelloJava.app"
