pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/zodttd.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/failkey.asc /usr/share/keyrings/zodttd-keyring.gpg
