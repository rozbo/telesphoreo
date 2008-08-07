pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/myhorse.pri.ee.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/comcute-keyring.gpg /usr/share/keyrings/pri.ee-keyring.gpg
