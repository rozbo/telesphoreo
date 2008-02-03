pkg:extract
cd *
pkg:patch
make
pkg: mkdir /Applications
pkg: mkdir -p /var/lib/cydia
pkg: cp -a data /Applications/Cydia.app
pkg: cp -a Cydia /Applications/Cydia.app
pkg: chmod +s /Applications/Cydia.app/Cydia
