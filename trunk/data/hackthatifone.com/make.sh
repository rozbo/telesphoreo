pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/hackthatifone.com.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/pubring.gpg /usr/share/keyrings/hackthatifone.com-keyring.gpg
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/hackthatifone_com.png /Applications/Cydia.app/Sources/hackthatifone.com.png
