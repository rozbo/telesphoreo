pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/saurik.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/saurik.key /usr/share/keyrings/saurik-keyring.gpg
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/apt.saurik.com.png /Applications/Cydia.app/Sources/apt.saurik.com.png
