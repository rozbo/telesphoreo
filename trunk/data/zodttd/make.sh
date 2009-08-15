pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/zodttd.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/failkey.asc /usr/share/keyrings/zodttd-keyring.gpg
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/www.zodttd.com.png /Applications/Cydia.app/Sources/cydia.zodttd.com.png
