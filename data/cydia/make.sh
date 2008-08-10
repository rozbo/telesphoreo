pkg:setup
cd cydia
make

pkg: mkdir -p /usr/libexec /var/lib/cydia
pkg: cp -a Library /usr/libexec/cydia
pkg: cp -a exec /usr/libexec/cydia
pkg: cp -a %/alert /usr/libexec/cydia

pkg: mkdir -p /System/Library
pkg: cp -a LaunchDaemons /System/Library

pkg: mkdir /Applications
pkg: cp -a Cydia.app /Applications
pkg: cp -a Cydia /Applications/Cydia.app/Cydia_
pkg: chmod +s /Applications/Cydia.app/Cydia_

pkg: mv /Applications/Cydia.app/Sources/iphonehe.{,com.png}

pkg: mkdir -p /System/Library/PreferenceBundles
pkg: cp -a CydiaSettings.bundle /System/Library/PreferenceBundles
