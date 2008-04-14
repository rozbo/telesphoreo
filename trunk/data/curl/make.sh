pkg:setup
autoconf
pkg:configure ac_cv_file___dev_urandom_=yes
make
pkg:install
