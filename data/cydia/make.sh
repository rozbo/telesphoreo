pkg:setup
cd cydia
make

pkg: mkdir -p /usr/libexec /var/lib/cydia
pkg: cp -a Library /usr/libexec/cydia

pkg: mkdir -p /System/Library
pkg: cp -a LaunchDaemons /System/Library

pkg: mkdir /Applications
pkg: cp -a Cydia.app /Applications
pkg: cp -a Cydia /Applications/Cydia.app/Cydia_
ldid -S"${PKG_DATA}/cydia.xml" "${PKG_DEST}/Applications/Cydia.app/Cydia_"
pkg: chmod +s /Applications/Cydia.app/Cydia_

pkg: mkdir -p /System/Library/PreferenceBundles
pkg: cp -a CydiaSettings.bundle /System/Library/PreferenceBundles
