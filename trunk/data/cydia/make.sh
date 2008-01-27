pkg:extract
cd *
make
pkg: mkdir /Applications
pkg: cp -a data /Applications/Packager.app
pkg: cp -a Cydia /Applications/Packager.app/Packager
pkg: chmod +s /Applications/Packager.app/Packager
