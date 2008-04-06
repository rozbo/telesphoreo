pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/ste.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/stepkg_key_2008.asc /usr/share/keyrings/ste-keyring.gpg
