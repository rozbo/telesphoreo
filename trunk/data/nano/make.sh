pkg:extract
cd *
pkg:configure
make
pkg:install
pkg: mkdir -p /etc/profile.d
pkg: cp -a %/nano.sh /etc/profile.d
