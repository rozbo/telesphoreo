pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/modmyifone.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/186902.txt /usr/share/keyrings/modmyifone-keyring.gpg
