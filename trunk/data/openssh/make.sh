pkg:extract
cd *
pkg:configure --disable-strip --sysconfdir=/etc/ssh
make
pkg:install INSTALL_SSH_RAND_HELPER=yes
pkg: cp -a %/sshd-keygen-wrapper /usr/libexec
pkg: mkdir -p /Library/LaunchDaemons
pkg: cp -a %/com.openssh.sshd.plist /Library/LaunchDaemons
pkg: cp -af %/ssh{d,}_config /etc/ssh
