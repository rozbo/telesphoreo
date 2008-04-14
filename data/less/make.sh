pkg:setup
pkg:configure
make
pkg:install
pkg: mkdir -p /etc/profile.d
pkg: cp -a %/less.sh /etc/profile.d
