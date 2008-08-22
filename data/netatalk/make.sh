pkg:setup
AR=$(which "${PKG_TARG}-ar") pkg:configure --enable-cups=no --sysconfdir=/etc
make
pkg:install
pkg: mkdir -p /System/Library/LaunchDaemons
pkg: cp -a %/net.sourceforge.netatalk.afpd.plist /System/Library/LaunchDaemons
