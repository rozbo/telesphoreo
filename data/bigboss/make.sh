pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/bigboss.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/bigboss.asc /usr/share/keyrings/bigboss-keyring.gpg
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/apt.bigboss.us.com.png /Applications/Cydia.app/Sources/apt.bigboss.us.com.png
pkg: mkdir -p /usr/share/bigboss
pkg: cp -a %/icons /usr/share/bigboss
