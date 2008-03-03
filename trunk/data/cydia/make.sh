pkg:extract
cd *
pkg:patch
make

pkg: mkdir -p /usr/libexec /var/lib/cydia
pkg: cp -a Library /usr/libexec/cydia
pkg: cp -a %/alert /usr/libexec/cydia

pkg: mkdir -p /System/Library/LaunchDaemons
pkg: mv /usr/libexec/cydia/com.saurik.Cydia.Firmware /System/Library/LaunchDaemons

pkg: mkdir /Applications
pkg: cp -a Cydia.app /Applications
pkg: cp -a Cydia /Applications/Cydia.app/Cydia_
pkg: chmod +s /Applications/Cydia.app/Cydia_

pkg: mkdir -p /System/Library/PreferenceBundles
pkg: cp -a CydiaSettings.bundle /System/Library/PreferenceBundles
