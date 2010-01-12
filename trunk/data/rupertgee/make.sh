pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/rupertgee.list /etc/apt/sources.list.d
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/redwolfberry.com.png /Applications/Cydia.app/Sources
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/rupertgee-keyring.gpg /usr/share/keyrings/rupertgee-keyring.gpg
