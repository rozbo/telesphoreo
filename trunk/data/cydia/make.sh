pkg:extract
cd *
pkg:patch
make

pkg: mkdir -p /var/lib/cydia

pkg: mkdir /Applications
pkg: cp -a Cydia.app /Applications
pkg: cp -a Cydia /Applications/Cydia.app/Cydia_
pkg: chmod +s /Applications/Cydia.app/Cydia_

pkg: mkdir -p /System/Library/PreferenceBundles
pkg: cp -a CydiaSettings.bundle /System/Library/PreferenceBundles
