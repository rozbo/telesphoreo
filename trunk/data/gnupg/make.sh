pkg:extract
cd *
pkg:patch
pkg:configure
make
pkg:install
pkg: rm -f /usr/share/gnupg/{FAQ,faq.html}
