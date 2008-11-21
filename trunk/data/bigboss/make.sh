pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/bigboss.list /etc/apt/sources.list.d
pkg: mkdir -p /usr/share/keyrings
pkg: cp -a %/bigboss.asc /usr/share/keyrings/bigboss-keyring.gpg
pkg: mkdir -p /usr/share/bigboss
pkg: cp -a %/icons /usr/share/bigboss
