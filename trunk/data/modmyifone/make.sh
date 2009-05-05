pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/modmyi.com.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/186902.txt /usr/share/keyrings/modmyi.com-keyring.gpg
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/apt.modmyi.com.png /Applications/Cydia.app/Sources/apt.modmyi.com.png
