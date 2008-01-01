pkg:extract
cd *
make all install PREFIX=/usr SYSCONFDIR=/etc DESTDIR=/home/saurik/telesphoreo/dest/nail UCBINSTALL=/usr/bin/install STRIP=arm-apple-darwin-strip CC=arm-apple-darwin-gcc
pkg: ln -s mailx /usr/bin/mail
