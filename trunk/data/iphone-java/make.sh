pkg: mkdir /Applications
javac -source 1.5 -d . -cp "$(PKG_DATA_ jocstrap)/jocstrap.jar:$(PKG_WORK_ javasqlite)/javasqlite-20080130/sqlite.jar" "${PKG_DATA}/HelloJava.app/HelloJava.java"
pkg: cp -a %/Hello{Java,Script}.app /Applications
cp -a *.class "${PKG_DEST}/Applications/HelloJava.app"
pkg: find / -name '.svn' -prune -exec rm -rfv {} \;
